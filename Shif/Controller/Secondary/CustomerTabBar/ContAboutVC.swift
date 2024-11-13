//
//  ContAboutVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class ContAboutVC: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var reqId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetAboutUs()
    }
    
    func GetAboutUs()
    {
        Api.shared.getProviderDetail(self, paramDetails()) { responseData in
            let obj = responseData
            self.lblDescription.text = obj.about_store ?? ""
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject]     = [:]
        dict["provider_id"]                = self.reqId as AnyObject
        print(dict)
        return dict
    }
}
