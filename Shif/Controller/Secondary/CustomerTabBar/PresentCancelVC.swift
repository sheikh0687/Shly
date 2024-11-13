//
//  PresentCancelVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 25/10/23.
//

import UIKit

class PresentCancelVC: UIViewController {

    @IBOutlet weak var lblReason: UILabel!
    @IBOutlet weak var txtReason: UITextView!
    
    var isComingStatus = ""
    
    var cloSubCancel:((_ cancelReason: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtReason.addHint(R.string.localizable.reason())
        if self.isComingStatus == "Accept" {
            self.lblReason.isHidden = true
        } else if isComingStatus == "PresentCancelVC"{
            self.lblReason.isHidden = true
        } else {
            self.lblReason.isHidden = false
        }
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        if self.txtReason.hasText {
            cloSubCancel?(self.txtReason.text!)
            self.dismiss(animated: true)
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheReason())
        }
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
