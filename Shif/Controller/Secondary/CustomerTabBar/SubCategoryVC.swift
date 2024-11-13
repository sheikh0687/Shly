//
//  SubCategoryVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/12/23.
//

import UIKit

class SubCategoryVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    var arrSubCategory: [Res_SubCategory] = []
    
    var selectedCatId = ""
    var selectedCatName = ""
    
    let lang = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVw.register(UINib(nibName: "SubCategoryCell", bundle: nil), forCellReuseIdentifier: "SubCategoryCell")
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.selectSubCategory(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.GetSubCategory()
    }
    
    func GetSubCategory() {
        Api.shared.getSubCategory(self, paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrSubCategory = responseData
            } else {
                self.arrSubCategory = []
            }
            self.tblVw.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject] {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["category_id"]            = self.selectedCatId as AnyObject
        print(dict)
        return dict
    }
}

extension SubCategoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSubCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell", for: indexPath) as! SubCategoryCell
        let obj = self.arrSubCategory[indexPath.row]
        if lang == "english" {
            cell.lblSubCategory.text = obj.name ?? ""
        } else {
            cell.lblSubCategory.text = obj.name_fr ?? ""
        }
        return cell
    }
}

extension SubCategoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        vc.catId = self.selectedCatId
        vc.catName = self.selectedCatName
        vc.subCatId = self.arrSubCategory[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
