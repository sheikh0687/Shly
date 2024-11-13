//
//  ConditionAndPolicyVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 19/03/24.
//

import UIKit

class ConditionAndPolicyVC: UIViewController {

    @IBOutlet weak var lblTermsCondition: UILabel!
    
    var which_Is = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.WebTermAndCondition()
        
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
        if which_Is == "TermAndCondition" {
            self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.termsAndConditions(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        } else if which_Is == "CGV" {
            self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "CGV", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        } else {
            self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.privacyPolicy(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func WebTermAndCondition()
    {
        Api.shared.getUserPlace(self) { responseData in
            let obj = responseData
            if self.which_Is == "TermAndCondition" {
                let html = obj.term_sp ?? ""
                if let attributedString = html.htmlAttributedString3 {
                    self.lblTermsCondition.attributedText = attributedString
                }
            } else if self.which_Is == "CGV" {
                let html = obj.cgv_sp ?? ""
                if let attributedString = html.htmlAttributedString3 {
                    self.lblTermsCondition.attributedText = attributedString
                }
            } else {
                let html = obj.privacy_sp ?? ""
                if let attributedString = html.htmlAttributedString3 {
                    self.lblTermsCondition.attributedText = attributedString
                }
            }
        }
    }
}
