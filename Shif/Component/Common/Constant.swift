//
//  Constant.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//


import Foundation
import UIKit

struct k {
    
    static let appName                                      =      "Shly"
    static var iosRegisterId                                =      "123456"
    static let emptyString                                  =      ""
    static let userDefault                                  =      UserDefaults.standard
    static let userType                                     =      ""
    static let currency                                     =      "€"
    static let themeColor                                   =      "#D1F6F3"
    static let navigationColor                              =      "#000000"
    
    struct languages
    {
        struct english
        {
            
            static let urlTermsCondition                    =      ""
            static let urlPrivacyPolicy                     =      ""
            static let urlAboutus                           =      ""
            static let urlhelp                              =      ""
            static let urlEULA                              =      ""
            
        }
    }
    
    struct session {
        static let status                                   =      "status"
        static let userId                                   =      "user_id"
        static let userName                                 =      "user_name"
        static let userEmail                                =      "user_email"
        static let userMobile                               =      "user_mobile"
        static let mobileWithCode                           =      "mobile_withCode"
        static let type                                     =      "type"
        static let customerId                               =      "customerId"
        static let catShortCode                             =      ""
        static let onlineStatus                             =      ""
        static let categoryId                               =      "category_id"
        static let subCategoryId                            =      "sub_cat_id"
        static let userImage                                =      "user_image"
        static let interestedRestId                         =      "interested_rest_id"
        static let lat                                      =      "lat"
        static let lon                                      =      "lon"
        static let restaurantName                           =      ""
        static let userLogin                                =      ""
        
        static let ads                                      =      ""
        static let gambling                                 =      ""
        static let malware                                  =      ""
        static let phishing                                 =      ""
        static let spyware                                  =      ""
        
        static let language                                 =      ""
        static let rejectCount                              =      ""
        static let currentCompanyId                         =      ""
    }
    
    
    struct google {
        static let googleApiKey                             =      ""
        static let googleClientId                           =      ""
    }
    
    struct facebook {
        static let facebookId                               =      ""
    }
    
    static var menuWidth: CGFloat                           =      0.0
    static var topMargin: CGFloat                           =      0.0
}


