//
//  GiveRatingVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import Cosmos

class GiveRatingVC: UIViewController {

    @IBOutlet weak var cosmosVw: CosmosView!
    @IBOutlet weak var txtFeedback: UITextView!
    
    var providerId = ""
    var reqId = ""
    
    var cloRefresh: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFeedback.addHint(R.string.localizable.enter())
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnRate(_ sender: UIButton) {
        if cosmosVw.rating.isZero {
            self.alert(alertmessage: R.string.localizable.pleaseSelectRating())
        } else if self.txtFeedback.text == "" {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheFeedback())
        } else {
            rate()
        }
    }
    
    func rate()
    {
        Api.shared.addRating(self, paramDetails()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.ratingSubmittedSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.cloRefresh?()
                self.dismiss(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject] {
        var dict: [String : AnyObject] = [:]
        dict["form_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["to_id"]                  = self.providerId as AnyObject
        dict["request_id"]             = self.reqId as AnyObject
        dict["rating"]                 = Double(self.cosmosVw.rating) as AnyObject
        dict["feedback"]               = self.txtFeedback.text as AnyObject
        dict["type"]                   = k.emptyString as AnyObject
        print(dict)
        return dict
    }
}
