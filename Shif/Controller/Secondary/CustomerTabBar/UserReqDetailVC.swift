//
//  UserReqDetailVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 19/01/24.
//

import UIKit
import MapKit

class UserReqDetailVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapVw: MKMapView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var priceTblVw: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_ProviderStatus: UILabel!
    
    var location_cordinate:CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    
    var arrServiceName: [Sub_Service_details] = []
    var request_Id = ""
    var adminPhone = ""
    var user_Name = ""
    var provider_Id = ""
    
    var isFromNotification:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceTblVw.register(UINib(nibName: "NewServiceCell", bundle: nil), forCellReuseIdentifier: "NewServiceCell")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapVw.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = hexStringToUIColor(hex: "#545454")
            
            // Set the appearance for this view controller's navigation bar
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.requestDetails(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.requestDetails()
    }
    
    override func leftClick() {
        if isFromNotification {
            Switcher.checkLoginStatus()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func requestDetails()
    {
        Api.shared.getRequestDetails(self, self.paramRequestDetail()) { responseData in
            let obj = responseData
            self.lblName.text = "\(obj.user_details?.first_name ?? "") \(obj.user_details?.last_name ?? "")"
            self.lblDate.text = obj.date ?? ""
            self.lblTime.text = obj.time_slot ?? ""
            self.lblTotalAmount.text = "\(k.currency) \(obj.total_amount ?? "")"
            self.adminPhone = obj.provider_details?.mobile_with_code ?? ""
            self.user_Name = obj.provider_details?.first_name ?? ""
            self.request_Id = obj.id ?? ""
            self.provider_Id = obj.provider_id ?? ""
            
            print(obj.status ?? "")
            let obj_Status = obj.status
            switch obj_Status {
            case "Accept":
                self.lbl_ProviderStatus.text = R.string.localizable.accepted()
            case "OnTheWay":
                self.lbl_ProviderStatus.text = R.string.localizable.yourProfessionalIsOnTheWay()
            case "Arrived":
                self.lbl_ProviderStatus.text = R.string.localizable.yourProfessionalArrivedOnYourLocation()
            case "Start":
                self.lbl_ProviderStatus.text = R.string.localizable.yourProfessionalStartWork()
            case "Pending":
                self.lbl_ProviderStatus.text = R.string.localizable.pending()
            default:
                self.lbl_ProviderStatus.text = R.string.localizable.completed()
            }
            
            let coordinate1 = CLLocationCoordinate2D(latitude: Double(obj.lat ?? "") ?? 0.0, longitude: Double(obj.lon ?? "") ?? 0.0)
            
            let annotation1 = CustomPointAnnotation()
            annotation1.coordinate = coordinate1
            annotation1.imageName = "provider"
            self.mapVw.addAnnotation(annotation1)
            
            self.zoomMapToAnnotations()
            
            if Router.BASE_IMAGE_URL != obj.user_details?.image {
                Utility.setImageWithSDWebImage(obj.user_details?.image ?? "", self.imgProfile)
            } else {
                self.imgProfile.image = R.image.placeholder()
            }
            
            if let serviceObj = obj.service_details {
                if serviceObj.count > 0 {
                    print(serviceObj)
                    print(serviceObj.count)
                    self.arrServiceName = serviceObj
                } else {
                    self.arrServiceName = []
                }
                self.priceTblVw.reloadData()
            }
        }
    }
    
    func paramRequestDetail() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        dict["request_id"]             = request_Id as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnChat(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.userName = self.user_Name
        vc.requestId = self.request_Id
        vc.receiverId = self.provider_Id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
        if Utility.isUserLogin() {
            let phoneNumber = self.adminPhone
            print(phoneNumber)// Replace with the contact number you want to open
            
            guard let url = URL(string: "tel://\(phoneNumber)") else {
                // Invalid URL
                // Handle the error condition here
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Device is not supporting the phone call!")
            }
        } else {
            self.alert(alertmessage: "Please register to use this app!")
        }
    }
    
    func zoomMapToAnnotations() {
        if !self.mapVw.annotations.isEmpty {
            let region = self.regionThatFitsAllAnnotations()
            self.mapVw.setRegion(region, animated: true)
        }
    }
    
    func regionThatFitsAllAnnotations() -> MKCoordinateRegion {
        var minLat = CLLocationDegrees(90)
        var maxLat = CLLocationDegrees(-90)
        var minLon = CLLocationDegrees(180)
        var maxLon = CLLocationDegrees(-180)
        
        for annotation in self.mapVw.annotations {
            let annotationCoordinate = annotation.coordinate
            minLat = min(minLat, annotationCoordinate.latitude)
            maxLat = max(maxLat, annotationCoordinate.latitude)
            minLon = min(minLon, annotationCoordinate.longitude)
            maxLon = max(maxLon, annotationCoordinate.longitude)
        }
        
        let center = CLLocationCoordinate2D(latitude: (maxLat + minLat) / 2, longitude: (maxLon + minLon) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.2, longitudeDelta: (maxLon - minLon) * 1.2)
        
        return MKCoordinateRegion(center: center, span: span)
    }
}

extension UserReqDetailVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrServiceName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewServiceCell", for: indexPath) as! NewServiceCell
        let obj = self.arrServiceName[indexPath.row]
        cell.lblServiceName.text = obj.service_name ?? ""
        cell.lblServicePrice.text = "\(k.currency) \(obj.service_rate ?? "")"
        self.tblHeight.constant = CGFloat(24 * self.arrServiceName.count)
        return cell
    }
}

extension UserReqDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24
    }
}

extension UserReqDetailVC: MKMapViewDelegate {
    
    // MKMapViewDelegate method to customize overlays (polylines)
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let gradientColors = [ hexStringToUIColor(hex: "#000000"), hexStringToUIColor(hex: "#000000")]
        
        /// Initialise a GradientPathRenderer with the colors
        let polylineRenderer = GradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
        
        /// set a linewidth
        polylineRenderer.lineWidth = 7
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        guard let customAnnotation = annotation as? CustomPointAnnotation else {
            return nil
        }
        
        let identifier = "CustomViewAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = customAnnotation
        }
        
        if let imageName = customAnnotation.imageName, let image = UIImage(named: imageName) {
            annotationView?.image = image
        } else {
            // Use a default image if the specified image is not found
            annotationView?.image = UIImage(named: "provider")
        }
        return annotationView
    }
}

