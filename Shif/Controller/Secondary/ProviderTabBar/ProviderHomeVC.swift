//
//  ProviderHomeVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit
import MapKit

class ProviderHomeVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var btnNewReqOt: UIButton!
    @IBOutlet weak var btnAcceptedOt: UIButton!
    @IBOutlet weak var btnCompleteOt: UIButton!
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var timer: Timer?
    
    var arrBookingStatus:[Res_ProoviderBookingStatus] = []
    
    var status = "Pending"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table_View.register(UINib(nibName: "ProviderNewReqCell", bundle: nil), forCellReuseIdentifier: "ProviderNewReqCell")
        self.table_View.register(UINib(nibName: "ProviderAcceptedCell", bundle: nil), forCellReuseIdentifier: "ProviderAcceptedCell")
        self.table_View.register(UINib(nibName: "ProviderCompletedCell", bundle: nil), forCellReuseIdentifier: "ProviderCompletedCell")
        
        setupMapView()
        setupLocationManager()
        
        timer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
        
        k.topMargin = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0) + 100
        self.btnNewReqOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnNewReqOt.setTitleColor(.white, for: .normal)
        self.btnAcceptedOt.backgroundColor = .white
        self.btnAcceptedOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnCompleteOt.backgroundColor = .white
        self.btnCompleteOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.getBookingStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = hexStringToUIColor(hex: "#FAFAFA")
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: R.string.localizable.home(), LeftImage: "", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func updateLocation() {
        // Fetch the user's current location
        if let userLocation = locationManager.location {
            // Call the API to update the location
            Utility.getCurrentAddress { address in
                self.update_ProviderLocation(userLocation.coordinate.latitude, userLocation.coordinate.longitude, address)
            }
        }
    }
    
    func update_ProviderLocation(_ lat: Double, _ lon: Double, _ address : String) {
        Api.shared.updateLocation(self, param_UpdateLocation(lat, lon, address)) { responseData in
            print(responseData)
            let val = responseData

            let coordinate = CLLocationCoordinate2D(latitude: Double(val.lat ?? "") ?? 0.0, longitude: Double(val.lon ?? "") ?? 0.0)

            // Update the existing annotation's coordinate or create a new one
            if let existingAnnotation = self.mapView.annotations.first(where: { $0 is CustomPointAnnotation }) as? CustomPointAnnotation {
                existingAnnotation.coordinate = coordinate
            } else {
                // Create a new annotation if it doesn't exist
                let annotation = CustomPointAnnotation(__coordinate: coordinate)
                annotation.imageName = "Location"
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func param_UpdateLocation(_ lat: Double,_ lon: Double,_ address: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["lat"]                    = lat as AnyObject
        dict["lon"]                    = lon as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnNewRequest(_ sender: UIButton) {
        self.btnNewReqOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnNewReqOt.setTitleColor(.white, for: .normal)
        self.btnAcceptedOt.backgroundColor = .white
        self.btnAcceptedOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnCompleteOt.backgroundColor = .white
        self.btnCompleteOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.status = "Pending"
        self.getBookingStatus()
    }
    
    @IBAction func btnAccpeted(_ sender: UIButton) {
        self.btnNewReqOt.backgroundColor = .white
        self.btnNewReqOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnAcceptedOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnAcceptedOt.setTitleColor(.white, for: .normal)
        self.btnCompleteOt.backgroundColor = .white
        self.btnCompleteOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.status = "Accept"
        self.getBookingStatus()
    }
    
    @IBAction func btnCompleted(_ sender: UIButton) {
        self.btnNewReqOt.backgroundColor = .white
        self.btnNewReqOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnAcceptedOt.backgroundColor = .white
        self.btnAcceptedOt.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnCompleteOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnCompleteOt.setTitleColor(.white, for: .normal)
        self.status = "Complete"
        self.getBookingStatus()
    }
}

//////////// Mark APi
///
extension ProviderHomeVC {
    
    func getBookingStatus()
    {
        Api.shared.getProviderBookingStatus(self, self.paramDetails()) { responseData in
            if responseData.count > 0
            {
                self.arrBookingStatus = responseData
            } else {
                self.arrBookingStatus = []
            }
            self.table_View.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_id"]            = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        dict["status"]                 = status as AnyObject
        dict["date"]                   = k.emptyString as AnyObject
        print(dict)
        return dict
    }
    
    func changeRequestStatus(_ userId: String,_ requestId: String,_ status: String,_ reason: String)
    {
        Api.shared.changeRequestStatus(self, paramChangeStatus(userId, requestId, status, reason)) { responseData in
            if status == "Accept" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourBookingAcceptedSuccessfullly(), delegate: nil, parentViewController: self) { bool in
                    self.getBookingStatus()
                    self.dismiss(animated: true)
                }
            } else if status == "Cancel" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.bookingHasBeenCancelledSuccessfully(), delegate: nil, parentViewController: self) { bool in
                    self.getBookingStatus()
                    self.dismiss(animated: true)
                }
            } else {
                self.getBookingStatus()
            }
        }
    }
    
    func paramChangeStatus(_ user_id: String,_ request_Id: String,_ status: String,_ cancelReason: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_id"]            = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["user_id"]                = user_id as AnyObject
        dict["request_id"]             = request_Id as AnyObject
        dict["status"]                 = status as AnyObject
        dict["reason_title"]           = cancelReason as AnyObject
        dict["reason_detail"]          = k.emptyString as AnyObject
        dict["cancelation_fee"]        = k.emptyString as AnyObject
        print(dict)
        return dict
    }
    
}


extension ProviderHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBookingStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if status == "Pending" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderNewReqCell", for: indexPath) as! ProviderNewReqCell
            cell.obj = self.arrBookingStatus[indexPath.row]
            let obj = self.arrBookingStatus[indexPath.row]
            cell.cloAccept = {() in
                let userId = obj.user_id ?? ""
                let requestId = obj.id ?? ""
                let status = "Accept"
                self.changeRequestStatus(userId, requestId, status, k.emptyString)
            }
            
            cell.cloCancel = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentCancelVC") as! PresentCancelVC
                vc.cloSubCancel = {(cancelReason) in
                    let userId = obj.user_id ?? ""
                    let requestId = obj.id ?? ""
                    let status = "Reject"
                    self.changeRequestStatus(userId, requestId, status, cancelReason)
                }
                vc.isComingStatus = "PresentCancelVC"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        } else if status == "Accept" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderAcceptedCell", for: indexPath) as! ProviderAcceptedCell
            cell.obj = self.arrBookingStatus[indexPath.row]
            
            let obj = self.arrBookingStatus[indexPath.row]
            
            let obj_Status = obj.status
            switch obj_Status {
            case "Accept":
                cell.btn_CompleteOt.setTitle(R.string.localizable.notifyOnTheWay(), for: .normal)
            case "OnTheWay":
                cell.btn_CompleteOt.setTitle(R.string.localizable.notifyArrived(), for: .normal)
            case "Arrived":
                cell.btn_CompleteOt.setTitle(R.string.localizable.notifyStart(), for: .normal)
            case "Start":
                cell.btn_CompleteOt.setTitle(R.string.localizable.notifyComplete(), for: .normal)
            default:
                print("")
            }
            
            cell.cloComplete = {() in
                switch obj_Status {
                case "Accept":
                    self.changeRequestStatus(obj.user_id ?? "", obj.id ?? "", "OnTheWay", k.emptyString)
                case "OnTheWay":
                    self.changeRequestStatus(obj.user_id ?? "", obj.id ?? "", "Arrived", k.emptyString)
                case "Arrived":
                    self.changeRequestStatus(obj.user_id ?? "", obj.id ?? "", "Start", k.emptyString)
                case "Start":
                    self.changeRequestStatus(obj.user_id ?? "", obj.id ?? "", "Complete", k.emptyString)
                default:
                    print("")
                }
            }
            
            cell.cloChat = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                vc.requestId = obj.id ?? ""
                vc.receiverId = obj.user_id ?? ""
                vc.userName = "\(obj.user_details?.first_name ?? "")"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.cloCancel = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentCancelVC") as! PresentCancelVC
                vc.cloSubCancel = {(cancelReason) in
                    let userId = obj.user_id ?? ""
                    let requestId = obj.id ?? ""
                    let status = "Reject"
                    self.changeRequestStatus(userId, requestId, status, cancelReason)
                }
                vc.isComingStatus = "PresentCancelVC"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderCompletedCell", for: indexPath) as! ProviderCompletedCell
            cell.obj = self.arrBookingStatus[indexPath.row]
            cell.cloGiveRating = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "GiveRatingVC") as! GiveRatingVC
                vc.providerId = cell.obj.user_id ?? ""
                vc.reqId = cell.obj.id ?? ""
                vc.cloRefresh = { () in
                    self.getBookingStatus()
                }
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        }
    }
}

extension ProviderHomeVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if status == "Pending"{
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderRequestDtVC") as! ProviderRequestDtVC
            vc.requestId = self.arrBookingStatus[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if status != "Complete" {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderRequestDtVC") as! ProviderRequestDtVC
            vc.requestId = self.arrBookingStatus[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension ProviderHomeVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKUserLocation else { return nil }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
        annotationView.image = UIImage(named: "Location")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //        if let overlay = overlay as? MKPolyline {
        /// define a list of colors you want in your gradient
        let gradientColors = [ hexStringToUIColor(hex: "#8728E2"), hexStringToUIColor(hex: "#3B67F7")]
        
        /// Initialise a GradientPathRenderer with the colors
        let polylineRenderer = GradientPathRenderer(polyline: overlay as! MKPolyline, colors: gradientColors)
        
        /// set a linewidth
        polylineRenderer.lineWidth = 7
        return polylineRenderer
        //        }
    }
}

extension ProviderHomeVC {
    func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension ProviderHomeVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Center the map on the user's location
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
    
}
