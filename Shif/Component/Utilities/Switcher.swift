//
//  Switcher.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 20/10/23.
//

import Foundation

class Switcher {
    
    class func checkLoginStatus()
    {
        if k.userDefault.value(forKey: k.session.userId) != nil {
                if let selectedType = k.userDefault.value(forKey: k.session.type)
                {
                    if selectedType as! String == "USER"
                    {
                        let homeVC = R.storyboard.main().instantiateViewController(withIdentifier: "CustomerTaBBarVC") as! CustomerTaBBarVC
                        let checkVC = UINavigationController(rootViewController: homeVC)
                        
                        kAppDelegate.window?.rootViewController = checkVC
                        kAppDelegate.window?.makeKeyAndVisible()
                    }
                    else
                    {
                        let homeVC = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderTabBarVC") as! ProviderTabBarVC
                        let checkVC = UINavigationController(rootViewController: homeVC)
                        
                        kAppDelegate.window?.rootViewController = checkVC
                        kAppDelegate.window?.makeKeyAndVisible()
                    }
                }
        } else {
            if isLogout {
                let mainVC = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let checkVC = UINavigationController(rootViewController: mainVC)
                
                kAppDelegate.window?.rootViewController = checkVC
                kAppDelegate.window?.makeKeyAndVisible()
            } else {
                let homeVC = R.storyboard.main().instantiateViewController(withIdentifier: "CustomerTaBBarVC") as! CustomerTaBBarVC
                let checkVC = UINavigationController(rootViewController: homeVC)
                
                kAppDelegate.window?.rootViewController = checkVC
                kAppDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
