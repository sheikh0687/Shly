//
//  ChangePasswordVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.changePassword(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        if self.txtNewPassword.hasText && txtCurrentPassword.hasText && txtConfirmPassword.hasText {
            WebChangePassword()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func WebChangePassword() {
        Api.shared.change_Password(self, self.paramDetails()) { responseData in
            self.alert(alertmessage: R.string.localizable.passwordChangedSuccessfully())
        }
    }
    
    func paramDetails() -> [String : AnyObject] {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["password"]               = self.txtNewPassword.text as AnyObject
        dict["old_password"]           = self.txtCurrentPassword.text as AnyObject
        return dict
    }
}
