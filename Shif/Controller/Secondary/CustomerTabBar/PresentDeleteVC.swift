//
//  PresentDeleteVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit

class PresentDeleteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnYes(_ sender: UIButton) {
        deleteUserAccount()
    }
    
    func deleteUserAccount() {
        Api.shared.deleteUserAccount(self) { responseData in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            Switcher.checkLoginStatus()
        }
    }
}
