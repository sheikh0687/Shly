//
//  SearchResultsVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class SearchResultsVC: UIViewController {

    @IBOutlet weak var btnListOt: UIButton!
    @IBOutlet weak var btnMapOt: UIButton!
    @IBOutlet weak var containerMap: UIView!
    @IBOutlet weak var containerList: UIView!
    
    var catId = ""
    var subCatId = ""
    var catName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnListOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnListOt.setTitleColor(.white, for: .normal)
        self.btnMapOt.backgroundColor = .white
        self.btnMapOt.setTitleColor(.gray, for: .normal)
        self.containerList.isHidden = false
        self.containerMap.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListVC" {
            if let vc = segue.destination as? ConListVC {
                vc.selectedCatId = self.catId
                vc.selectedCatName = self.catName
                vc.selectedSubCatId = self.subCatId
            }
        }
        
        if segue.identifier == "MapVC" {
            if let vc = segue.destination as? ConMapVC {
                vc.selectedCatId = self.catId
                vc.selectedSubCatId = self.subCatId
                vc.selectedCatName = self.catName
            }
        }
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.searchResults(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnList(_ sender: UIButton) {
        self.btnListOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnListOt.setTitleColor(.white, for: .normal)
        self.btnMapOt.backgroundColor = .white
        self.btnMapOt.setTitleColor(.gray, for: .normal)
        self.containerList.isHidden = false
        self.containerMap.isHidden = true
    }
    
    @IBAction func btnMap(_ sender: UIButton) {
        self.btnListOt.backgroundColor = .white
        self.btnListOt.setTitleColor(.gray, for: .normal)
        self.btnMapOt.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnMapOt.setTitleColor(.white, for: .normal)
        self.containerList.isHidden = true
        self.containerMap.isHidden = false
    }
}
