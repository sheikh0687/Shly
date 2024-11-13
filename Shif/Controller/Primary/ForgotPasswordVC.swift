//
//  ForgotPasswordVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.forgotPassword(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        if self.txtEmail.hasText {
          WebResestPassword()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheValidEmail())
        }
    }
    
    func WebResestPassword()
    {
        Api.shared.WebForgetPassword(self, paramDetails()) { responseData in
            if responseData.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.newPasswordHasSentToYourEmail(), delegate: nil, parentViewController: self) { boool in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: responseData.result ?? "", delegate: nil, parentViewController: self)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["email"]                  = txtEmail.text as AnyObject
        return dict
    }
}
