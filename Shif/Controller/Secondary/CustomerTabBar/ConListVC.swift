//
//  ConListVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit
import CoreLocation

class ConListVC: UIViewController {
    
    @IBOutlet weak var tblVwOt: UITableView!
    
    var selectedCatId = ""
    var selectedCatName = ""
    var selectedSubCatId = ""
    var lat = 0.0
    var lon = 0.0
    var arrFilterList: [Res_ServiceFilter] = []
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filterService()
    }
    
    func filterService()
    {
        Api.shared.getServiceFilter(self, self.paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrFilterList = responseData
            } else {
                self.arrFilterList = []
            }
            self.tblVwOt.reloadData()
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
}

extension ConListVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFilterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        cell.obj = self.arrFilterList[indexPath.row]
        cell.cloDetails = {() in
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.reqId = self.arrFilterList[indexPath.row].id ?? ""
            vc.catId = self.selectedCatId
            vc.catName = self.selectedCatName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}
