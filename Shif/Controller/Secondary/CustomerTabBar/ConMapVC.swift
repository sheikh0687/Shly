//
//  ConMapVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit
import MapKit

class ConMapVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var location_cordinate:CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
    
    var arrFilterList: [Res_ServiceFilter] = []
    
    var selectedCatId = ""
    var selectedCatName = ""
    var selectedSubCatId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.GetFilterService()
    }
    
    func GetFilterService()
    {
        Api.shared.getServiceFilter(self, self.paramDetails()) { responseData in
            if responseData.count > 0
            {
                self.arrFilterList = responseData
                
                let obj = responseData
                
                for val in obj {
                    
                    let coordinate1 = CLLocationCoordinate2D(latitude: Double(val.lat ?? "") ?? 0.0, longitude: Double(val.lon ?? "") ?? 0.0)
                    
                    let annotation1 = CustomPointAnnotation()
                    annotation1.coordinate = coordinate1
                    annotation1.title = val.type ?? ""
                    annotation1.providerId = val.id ?? ""
                    annotation1.imageName = "provider"
                    self.mapView.addAnnotation(annotation1)
                    
                }
                self.zoomMapToAnnotations()
            } else {
                self.arrFilterList = []
            }
            self.mapView.reloadInputViews()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["cat_id"]                 = self.selectedCatId as AnyObject
        dict["sub_cat_id"]             = self.selectedSubCatId as AnyObject
        dict["lat"]                    = kAppDelegate.CURRENT_LAT as AnyObject
        dict["lon"]                    = kAppDelegate.CURRENT_LON as AnyObject
        print(dict)
        return dict
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Handle the tap action on the selected annotation view here
        if let customAnnotation = view.annotation as? CustomPointAnnotation {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.reqId = customAnnotation.providerId
            vc.catId = self.selectedCatId
            vc.catName = self.selectedCatName
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func zoomMapToAnnotations() {
        if !self.mapView.annotations.isEmpty {
            let region = self.regionThatFitsAllAnnotations()
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func regionThatFitsAllAnnotations() -> MKCoordinateRegion {
        var minLat = CLLocationDegrees(90)
        var maxLat = CLLocationDegrees(-90)
        var minLon = CLLocationDegrees(180)
        var maxLon = CLLocationDegrees(-180)
        
        for annotation in self.mapView.annotations {
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

extension ConMapVC: MKMapViewDelegate {
    
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

