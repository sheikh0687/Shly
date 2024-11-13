//
//  ProWalletAmountVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 06/02/24.
//

import UIKit

class ProWalletAmountVC: UIViewController {
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var txtAccountNum: UITextField!
    @IBOutlet weak var txtAccountHoldName: UITextField!
    @IBOutlet weak var txtIfscCode: UITextField!
    @IBOutlet weak var txtBankBranch: UITextField!
    
    var amount:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let netAmount = amount, netAmount != "" {
            self.lblTotalAmount.text! = self.amount
        } else {
            self.lblTotalAmount.text! = "0.0"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.withdraw(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        if txtAccountNum.hasText && txtAccountHoldName.hasText && txtIfscCode.hasText && txtBankBranch.hasText {
            self.addRequest()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func addRequest()
    {
        Api.shared.add_Wallet_Request(self, self.paramDetails()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.requestAddedSuccessfully(), delegate: nil, parentViewController: self) { boool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["amount"]                 = self.lblTotalAmount.text as AnyObject
        dict["account_number"]         = self.txtAccountNum.text as AnyObject
        dict["account_holder_name"]    = self.txtAccountHoldName.text as AnyObject
        dict["ifsc_code"]              = self.txtIfscCode.text as AnyObject
        dict["description"]            = k.emptyString as AnyObject
        dict["branch"]                 = self.txtBankBranch.text as AnyObject
        return dict
    }
}
