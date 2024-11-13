//
//  AppDelegate.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit
import CoreLocation
import IQKeyboardManagerSwift
import StripeCore
import FirebaseCore
import FirebaseMessaging

let Kstoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var coordinate1 = CLLocation(latitude: 0.0, longitude: 0.0)
    var coordinate2 = CLLocation(latitude: 0.0, longitude: 0.0)
    var CURRENT_LAT = ""
    var CURRENT_LON = ""
    var obTabBar: CustomerTaBBarVC? = nil
    var navController: UINavigationController? = nil
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let user_Type = k.userDefault.value(forKey: k.session.type) as? String
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        StripeAPI.defaultPublishableKey = "pk_test_51NxpEnC99UBj0tzf9Dv5pBEjSfiZovaIkNtRmEZC2VihHmvCh3U8wlNEcp88VMZYC8ZYwBDJ9gSY7M9QCpCLhxw500sHBLO4LQ"
        
        IQKeyboardManager.shared.enable = true
        LocationManager.sharedInstance.delegate = kAppDelegate
        LocationManager.sharedInstance.startUpdatingLocation()
        Switcher.checkLoginStatus()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        notificationCenter.delegate = self
        self.configureNotification()
        L102Localizer.DoTheMagic()
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundEffect = .none
            tabBarAppearance.shadowColor = .clear
            tabBarAppearance.backgroundColor = UIColor.white
            
            let tabBarItemAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 8)] // Adjust the font size as per your preference
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = tabBarItemAttributes
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = tabBarItemAttributes
            
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func hexStringToUIColorApp (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func configureNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        }
        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                k.iosRegisterId = token
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        k.iosRegisterId = deviceTokenString
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    
    // MARK:-  Received Remote Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject> {
            print(info)
            let statuss = userInfo["gcm.notification.ios_status"] as? String
            guard let status = statuss else { return }
            if status == "New booking request" {
                handleNewRequestStatus(userInfo)
            } else if status == "You have a new message" {
                handleNotification(userInfo)
            } else if status == "Request Accept" {
                handleRequestStatus(userInfo)
            } else if status == "Request OnTheWay" {
                handleRequestStatus(userInfo)
            } else if status == "Request Arrived" {
                handleRequestStatus(userInfo)
            } else if status == "Request Start" {
                handleRequestStatus(userInfo)
            } else {
                handleRequestStatus(userInfo)
            }
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func handleNotification(_ userInfo: Dictionary<AnyHashable, Any>) {
        let info = userInfo as? Dictionary<String, AnyObject>
        if UIApplication.topViewController() != nil {
            DispatchQueue.main.async {
                if let rVC = UIApplication.topViewController(), rVC is ChatVC {
                    let rootVC = rVC as! ChatVC
                    rootVC.getChat()
                } else {
                    print("Notification Chat printed!!!!!")
                }
            }
        }
    }
    
    func handleRequestStatus(_ userInfo: Dictionary<AnyHashable, Any>) {
        let info = userInfo as? Dictionary<String, AnyObject>
        if UIApplication.topViewController() != nil {
            DispatchQueue.main.async {
                if let rVC = UIApplication.topViewController(), rVC is UserMyOrderVC {
                    let rootVC = rVC as! UserMyOrderVC
                    rootVC.GetBookingStaus()
                } else {
                    print("Notification Chat printed!!!!!")
                }
            }
        }
    }
    
    func handleNewRequestStatus(_ userInfo: Dictionary<AnyHashable, Any>) {
        let info = userInfo as? Dictionary<String, AnyObject>
        if UIApplication.topViewController() != nil {
            DispatchQueue.main.async {
                if let rVC = UIApplication.topViewController(), rVC is ProviderHomeVC {
                    let rootVC = rVC as! ProviderHomeVC
                    rootVC.getBookingStatus()
                } else {
                    print("Notification Chat printed!!!!!")
                }
            }
        }
    }
}

extension AppDelegate: LocationManagerDelegate {
    
    func didEnterInCircularArea() {
        print("")
    }
    
    func didExitCircularArea() {
        print("")
    }
    
    func tracingLocation(currentLocation: CLLocation) {
        coordinate2 = currentLocation
        print(coordinate2)
        let distanceInMeters = coordinate1.distance(from: coordinate2) // result is in meters
        if distanceInMeters > 250 {
            CURRENT_LAT = String(currentLocation.coordinate.latitude)
            print(CURRENT_LAT)
            CURRENT_LON = String(currentLocation.coordinate.longitude)
            coordinate1 = currentLocation
            if let _ = UserDefaults.standard.value(forKey: "user_id") {
                //self.updateLatLon()
            }
        }
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("tracing Location Error : \(error.description)")
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let info = userInfo as? Dictionary<String, AnyObject> {
            print(info)
            let alert1 = info["aps"]!["alert"] as! Dictionary<String, AnyObject>
            let title = userInfo["gcm.notification.text"]  ?? ""
            print(title)
            self.redirectNotification(info, title as! String)
        }
        completionHandler()
    }
    
    func showNotification(_ heading: String, _ message: String) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: heading, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: message, arguments: nil)
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "driver_arrived"
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest.init(identifier: "notify-test", content: content, trigger: trigger)
        kAppDelegate.notificationCenter.add(request) { (errorr) in}
    }
    
    func redirectNotification(_ userInfo: Dictionary<String, AnyObject>,_ tittle: String) {
        
        let visibleVC = UIApplication.topViewController()
        
        if tittle == "New booking request" {
            if UIApplication.topViewController() != nil {
                DispatchQueue.main.async {
                    self.handleRequestAccept()
                }
            }
        } else if tittle == "Vous avez un nouveau message" {
            if UIApplication.topViewController() != nil {
                DispatchQueue.main.async {
                    let receiverId = userInfo["gcm.notification.s_id"] as? String ?? ""
                    let userName = userInfo["gcm.notification.first_name"] as? String ?? ""
                    let requestId = userInfo["gcm.notification.request_id"] as? String ?? ""
                    print(receiverId)
                    print(userName)
                    print(requestId)
                    self.handleChat(receiverId, userName, requestId)
                }
            }
        } else if tittle == "Votre demande est acceptée par le professionnel" {
            if user_Type == "USER" {
                let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "UserReqDetailVC") as! UserReqDetailVC
                let nav = UINavigationController(rootViewController: rootVC)
                nav.isNavigationBarHidden = false
                rootVC.isFromNotification = true
                rootVC.request_Id = userInfo["gcm.notification.request_id"] as? String ?? ""
                kAppDelegate.window!.rootViewController = nav
                kAppDelegate.window?.makeKeyAndVisible()
            } else {
                Switcher.checkLoginStatus()
            }
        } else {
            Switcher.checkLoginStatus()
        }
    }
    
    func handleRequestAccept() {
        Switcher.checkLoginStatus()
    }
    
    func handleChat(_ receiverId: String, _ userName: String, _ requestId: String) {
        let rootVC = R.storyboard.main().instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        let nav = UINavigationController(rootViewController: rootVC)
        nav.isNavigationBarHidden = false
        rootVC.isFromNotification = true
        rootVC.receiverId = receiverId
        rootVC.userName = userName
        rootVC.requestId = requestId
        kAppDelegate.window!.rootViewController = nav
        kAppDelegate.window?.makeKeyAndVisible()
    }
}

