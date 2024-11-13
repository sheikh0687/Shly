//
//  LoginVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnHidePassOt: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    
    var isUserLogin:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnHidePassOt.setImage(R.image.hidePassword(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        if Utility.isUserLogin() {
            self.navigationController?.navigationBar.isHidden = true
        } else {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    @IBAction func btnSignup(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(identifier: "TypeVC") as! TypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnShowPassword(_ sender: UIButton) {
        if btnHidePassOt.image(for: .normal) == R.image.hidePassword() {
            btnHidePassOt.setImage(R.image.showPassword(), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        } else {
            btnHidePassOt.setImage(R.image.hidePassword(), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if txtEmail.hasText && txtPassword.hasText {
            CheckLoginStatus()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func CheckLoginStatus()
    {
        Api.shared.login(self, self.paramDetails()) { responseData in
            if responseData.type == "PROVIDER" && responseData.status == "Deactive" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourAccountIsBeingVerifiedPleaseWaitForTheAdministratorSApprovalBeforeUsingTheApplicationThankYouForYourUnderstanding(), delegate: nil, parentViewController: self) { bool in
                    self.dismiss(animated: true)
                }
            } else {
                k.userDefault.set(true, forKey: k.session.status)
                k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
                k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
                k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
                k.userDefault.set(responseData.type ?? "", forKey: k.session.type)
                k.userDefault.set(responseData.customer_id, forKey: k.session.customerId)
                k.userDefault.set(responseData.mobile ?? "", forKey: k.session.userMobile)
                k.userDefault.set(responseData.mobile_with_code ?? "", forKey: k.session.mobileWithCode)
                Switcher.checkLoginStatus()
                print(responseData)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["email"]                  = self.txtEmail.text as AnyObject
        dict["password"]               = self.txtPassword.text as AnyObject
        dict["register_id"]            = k.emptyString as AnyObject
        dict["ios_register_id"]        = k.iosRegisterId as AnyObject
        dict["lat"]                    = kAppDelegate.CURRENT_LON as AnyObject
        dict["lon"]                    = kAppDelegate.CURRENT_LON as AnyObject
        print(dict)
        return dict
    }
}
