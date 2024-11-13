//
//  AddressVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class AddressVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    
    var arrAddress: [Res_Address] = []
    
    var addressVal = ""
    var lat = 0.0
    var lon = 0.0
    
    var cloSelectAddress:((_ addressVal: String,_ latVal: Double,_ lonVal: Double,_ addressId: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = hexStringToUIColor(hex: "#545454")
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.myAddress(), CenterImage: "", RightTitle: "", RightImage: "Plus24", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.WebGetAddress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = {(a,b,c,d) in
            self.WebGetAddress()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func WebGetAddress()
    {
        Api.shared.getAddress(self) { responseData in
            if responseData.count > 0 {
                self.arrAddress = responseData
            } else {
                self.arrAddress = []
            }
            self.tblVwOt.reloadData()
        }
    }
    
    func DeleteSavedAddress(_ addressId: String)
    {
        Api.shared.deleteAddress(self, paramDetails(addressId)) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.addressDeletedSuccessfully(), delegate: nil, parentViewController: self) { boool in
                self.WebGetAddress()
            }
        }
    }
    
    func paramDetails(_ addressId: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["address_id"]             = addressId as AnyObject
        print(dict)
        return dict
    }
}

extension AddressVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        cell.obj = self.arrAddress[indexPath.row]
        
        cell.cloDelete = {() in
            let id = cell.obj.id ?? ""
            print(id)
            self.DeleteSavedAddress(id)
        }
        
        cell.cloChoose = { () in
            self.addressVal = cell.obj.address ?? ""
            self.lat = Double(cell.obj.lat ?? "") ?? 0.0
            self.lon = Double(cell.obj.lon ?? "") ?? 0.0
            let id = cell.obj.id ?? ""
            self.cloSelectAddress?(self.addressVal, self.lat, self.lon, id)
            self.navigationController?.popViewController(animated: true)
        }
        return cell
    }
}
