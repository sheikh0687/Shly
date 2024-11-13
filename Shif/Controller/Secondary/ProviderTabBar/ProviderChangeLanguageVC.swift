//
//  ProviderChangeLanguageVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit

class ProviderChangeLanguageVC: UIViewController {

    @IBOutlet weak var btnEnglishOt: UIButton!
    @IBOutlet weak var btnFrenchOt: UIButton!
    
    var selectedLanguage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let language = k.userDefault.value(forKey: k.session.language) as? String,
           language == "english" {
            self.btnEnglishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        } else {
            self.btnFrenchOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.language(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    @IBAction func btnEnglish(_ sender: UIButton) {
        self.btnEnglishOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        self.btnFrenchOt.setImage(R.image.ic_Circle_Black(), for: .normal)
        self.selectedLanguage = "en"
    }
    
    @IBAction func btnFrench(_ sender: UIButton) {
        self.btnEnglishOt.setImage(R.image.ic_Circle_Black(), for: .normal)
        self.btnFrenchOt.setImage(R.image.ic_CheckedCircle_Black(), for: .normal)
        self.selectedLanguage = "fr"
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        if selectedLanguage == "en" {
            k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
            L102Language.setAppleLAnguageTo(lang: "en")
            Switcher.checkLoginStatus()
        } else {
            k.userDefault.set(emLang.french.rawValue, forKey: k.session.language)
            L102Language.setAppleLAnguageTo(lang: "fr")
            Switcher.checkLoginStatus()
        }
    }
}
