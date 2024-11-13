//
//  OtpVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/01/24.
//

import UIKit
import StripePayments
import SwiftyJSON

class OtpVC: UIViewController {
    
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    
    var params: [String: String] = [:]
    var mobileNo = ""
    var mobile = ""
    var verificationCode = ""
    var verifyCode = ""
    
    var card_Param: STPCardParams!
    
    var cloResend:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mobile = k.userDefault.value(forKey: k.session.userMobile) as? String
        self.lblMobile.text = "A code has been sent to \(mobile ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: "Confirm Number", CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func txt1(_ sender: UITextField) {
        if sender.text! != "" {
            self.txt2.becomeFirstResponder()
        }
    }
    
    @IBAction func txt2(_ sender: UITextField) {
        if sender.text! == "" {
            self.txt1.becomeFirstResponder()
        } else {
            self.txt3.becomeFirstResponder()
        }
    }
    
    @IBAction func txt3(_ sender: UITextField) {
        if sender.text! == "" {
            self.txt2.becomeFirstResponder()
        } else {
            self.txt4.becomeFirstResponder()
        }
    }
    
    @IBAction func txt4(_ sender: UITextField) {
        if sender.text! == "" {
            self.txt3.becomeFirstResponder()
        }
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if txt1.hasText && txt2.hasText && txt3.hasText && txt4.hasText {
            let v1 = self.txt1.text!
            let v2 = self.txt2.text!
            let v3 = self.txt3.text!
            let v4 = self.txt4.text!
            let verificationCode = "\(v1)\(v2)\(v3)\(v4)"
            self.otpVerification(verificationCode)
        } else {
            self.alert(alertmessage: "Please Enter Otp")
        }
    }
    
    func otpVerification(_ verificationCode: String) {
        let otpp = String(verificationCode)
        if self.verificationCode == otpp {
            self.generateToken(card_Param)
        } else {
            self.txt1.text = ""
            self.txt2.text = ""
            self.txt3.text = ""
            self.txt4.text = ""
            self.txt1.becomeFirstResponder()
            self.alert(alertmessage: "Invalid Otp")
        }
    }
    
    func generateToken(_ cardParams: STPCardParams)
    {
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.somethingWentWrong(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
                return
            }
            print(token.tokenId)
            self.save_Cards(token.tokenId)
        }
    }
    
    
    func save_Cards(_ token: String)
    {
        Api.shared.add_Card(self, param_Add_Card(token)) { responseData in
            self.parseDataSaveCard(apiResponse: responseData)
        }
    }
    
    func param_Add_Card(_ tokenId: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["customer_id"]            = k.userDefault.value(forKey: k.session.customerId) as AnyObject
        dict["tok_visa"]               = tokenId as AnyObject
        print(dict)
        return dict
    }
    
    func parseDataSaveCard(apiResponse : AnyObject) {
        DispatchQueue.main.async {
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == "1") {
                print(swiftyJsonVar["result"]["id"].stringValue)
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.cardSavedSuccessfully(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                    self.navigationController?.popViewController(animated: true)
                })

            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.somethingWentWrong(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
            }
            self.unBlockUi()
        }
    }
    
    @IBAction func btnResend(_ sender: UIButton) {
        self.cloResend?()
    }
}
