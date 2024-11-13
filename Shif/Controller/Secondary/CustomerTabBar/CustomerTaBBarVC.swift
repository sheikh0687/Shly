//
//  CustomerTaBBarVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class CustomerTaBBarVC: UITabBarController {
    
    var isFromNotification = false
    
    override func viewDidLoad() {
        self.delegate = self
        super.viewDidLoad()
        kAppDelegate.obTabBar = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension CustomerTaBBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.restorationIdentifier == "My Order" || viewController.restorationIdentifier == "Chat" || viewController.restorationIdentifier == "Setting" {
            if !Utility.isUserLogin() {
                print("User not logged in. Redirecting to LoginVC.")
                let loginVC = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(loginVC, animated: true)
                return false
            }
        }
        return true
    }
}
