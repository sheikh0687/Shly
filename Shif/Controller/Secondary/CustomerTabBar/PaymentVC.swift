//
//  PaymentVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 28/10/23.
//

import UIKit
import InputMask
import SwiftyJSON
import StripePayments


class PaymentVC: UIViewController {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet var listnerCardNum: MaskedTextFieldDelegate!
    @IBOutlet var listerExpiryDate: MaskedTextFieldDelegate!
    
    var amount = 0.0
    var planId = ""
    var requestId = ""
    var providerId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.lblAmount.text = "\(k.currency) \(self.amount)"
        self.configureListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.addCard(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureListener()
    {
        listnerCardNum.affinityCalculationStrategy = .prefix
        listnerCardNum.affineFormats = ["[0000] [0000] [0000] [0000]"]
        
        listerExpiryDate.affinityCalculationStrategy = .prefix
        listerExpiryDate.affineFormats = ["[00]/[00]"]
    }
    
    func cardValidation()
    {
        let cardParams = STPCardParams()
        
        // Split the expiration date to extract Month & Year
        if self.txtCardHolderName.text?.isEmpty == false && self.txtSecurityCode.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false {
            let expirationDate = self.txtExpiryDate.text?.components(separatedBy: "/")
            let expMonth = UInt((expirationDate?[0])!)
            let expYear = UInt((expirationDate?[1])!)
            
            // Send the card info to Strip to get the token
            cardParams.number = self.txtCardNumber.text
            cardParams.cvc = self.txtSecurityCode.text
            cardParams.expMonth = expMonth!
            cardParams.expYear = expYear!
        }
        
        let cardState = STPCardValidator.validationState(forCard: cardParams)
        switch cardState {
        case .valid:
//            self.verifyOtp(cardParams)
            self.generateToken(cardParams)
        case .invalid:
            self.alert(alertmessage: R.string.localizable.cardIsInvalid())
        case .incomplete:
            self.alert(alertmessage: R.string.localizable.cardIsIncomplete())
        default:
            print("default")
        }
    }
    
    func verifyOtp(_ cardParam: STPCardParams,shouldNavigate: Bool = true) {
        print(self.paramVerifyOtp())
        Api.shared.verifyOtp(self, self.paramVerifyOtp()) { (response) in
            print(response.code ?? 0)
            if shouldNavigate  {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                vc.verificationCode = String(response.code ?? "")
                vc.verifyCode = String(response.code ?? "")
                vc.card_Param = cardParam
                vc.cloResend = {() in
                    self.verifyOtp(cardParam, shouldNavigate: false)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func paramVerifyOtp() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["mobile_with_code"] = k.userDefault.value(forKey: k.session.mobileWithCode) as AnyObject
        dict["mobile"] = k.userDefault.value(forKey: k.session.userMobile) as AnyObject
        dict["email"] = k.userDefault.value(forKey: k.session.userEmail) as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnSubmit(_ sender: UIButton)
    {
        self.cardValidation()
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
    
//    func stripePayment(_ token: String)
//    {
//        Api.shared.stripePayment(self, self.paramStripe(token)) { responseData in
//            self.parseDataSaveCard(apiResponse: responseData)
//        }
//    }
//    
// 
//    
//    func paramStripe(_ tokenId: String) -> [String : AnyObject]
//    {
//        var dict: [String : AnyObject] = [:]
//        
//        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId)! as AnyObject
//        dict["payment_method"]         = "Card" as AnyObject
//        dict["currency"]               = "EUR" as AnyObject
//        dict["total_amount"]           = self.amount as AnyObject
//        dict["token"]                  = tokenId as AnyObject
//        dict["request_id"]             = self.requestId as AnyObject
//        dict["provider_id"]            = self.providerId as AnyObject
//        print(dict)
//        return dict
//    }
    
//    func paramAddPlan(_ transactionId: String) -> [String:AnyObject]
//    {
//        var dict : [String:AnyObject] = [:]
//        dict["user_id"]               = k.userDefault.value(forKey: k.session.userId)! as AnyObject
//        dict["amount"]                = self.amount as AnyObject
//        dict["transaction_id"]        = transactionId as AnyObject
//        dict["plan_id"]               = self.planId as AnyObject
//        return dict
//    }
//    
//    
//    func addPayment(_ transactionId: String) {
//        print(self.paramAddPlan(transactionId))
////        Api.shared.PlanPurchase(self, self.paramAddPlan(transactionId)) { (response) in
////            Utility.showAlertWithAction(withTitle: k.appName, message: "Transaction Is Successfull", delegate: nil, parentViewController: self, completionHandler: { (boool) in
////                self.dismiss(animated: true) {
////                    Switcher.checkLoginStatus()
////                }
////            })
////        }
//    }
}

