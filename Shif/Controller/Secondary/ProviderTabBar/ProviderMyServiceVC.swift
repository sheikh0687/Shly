//
//  ProviderMyServiceVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit

class ProviderMyServiceVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    
    var arrProviderSerive: [Res_ServiceList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "MyServiceCell", bundle: nil), forCellReuseIdentifier: "MyServiceCell")
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.myService(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.providerService()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnPlus(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderServiceVC") as! ProviderServiceVC
        vc.isComingFrom = "ProviderMyServiceVC"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func providerService()
    {
        Api.shared.getProviderService(self, self.paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrProviderSerive = responseData
            } else {
                self.arrProviderSerive = []
            }
            self.tblVwOt.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        print(dict)
        return dict
    }
    
    func deleteService(_ id: String)
    {
        Api.shared.deleteService(self, self.deleteServiceParam(id)) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.deletedSuccessfully(), delegate: nil, parentViewController: self) { Boool in
                self.providerService()
            }
        }
    }
    
    func deleteServiceParam(_ serviceId: String) -> [String : AnyObject] 
    {
        var dict: [String : AnyObject] = [:]
        dict["service_id"]             = serviceId as AnyObject
        print(dict)
        return dict
    }
}

extension ProviderMyServiceVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProviderSerive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyServiceCell", for: indexPath) as! MyServiceCell
        cell.obj = self.arrProviderSerive[indexPath.row]
        cell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            cell.selectedName = item
            if index == 0 {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderUpdateServiceVC") as! ProviderUpdateServiceVC
                vc.requestId = cell.obj.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let serviceId = cell.obj.id ?? ""
                print(serviceId)
                self.deleteService(serviceId)
            }
        }
        return cell
    }
}
