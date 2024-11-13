//
//  TypeVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

struct allData
{
    var name: String?
    var description: String?
    var img: UIImage?
}

class TypeVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    var arr_AllData = [allData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVw.register(UINib(nibName: "TypeCell", bundle: nil), forCellReuseIdentifier: "TypeCell")
        arr_AllData =
        [
            allData(name: R.string.localizable.customeR(), description: R.string.localizable.iWantToLookGoodINeedToBook(), img: UIImage(named: "ClientNew")),
            allData(name: R.string.localizable.provideR(), description: R.string.localizable.iAmTheManagerOfAHairProviderAndIWantToAddMyProvider(), img: UIImage(named: "ProviderNew"))
        ]
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.chooseAccountType(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if Utility.isUserLogin() {
           self.navigationController?.navigationBar.isHidden = true
        } else {
           self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TypeVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_AllData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath) as! TypeCell
        cell.lblCustomer.text = self.arr_AllData[indexPath.row].name
        cell.lblDescription.text = self.arr_AllData[indexPath.row].description
        cell.img.image = self.arr_AllData[indexPath.row].img
        return cell
    }
}

extension TypeVC: UITableViewDelegate
{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 240
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            vc.typee = "USER"
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            vc.typee = "PROVIDER"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


