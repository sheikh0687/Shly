//
//  PresentConfirmationVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 19/01/24.
//

import UIKit

class PresentConfirmationVC: UIViewController {
    
    @IBOutlet weak var progressVw: UIProgressView!
    
    var provider_Id = ""
    var request_Id = ""
    var statuss: Bool = true
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressVw.progress = 0.0
        self.doStuff()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = hexStringToUIColor(hex: "#545454")
            
            // Set the appearance for this view controller's navigation bar
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.confirmBooking(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
//        self.progressVw.layer.removeAllAnimations()
    }
    
    override func leftClick() {
        Switcher.checkLoginStatus()
        timer?.invalidate()
    }
    
    //    func updateProgressWithAnimation() {
    //        let targetProgress: Float = 1
    //        let animationDuration: TimeInterval = 100.0
    //        let numberOfIntervals: Int = 10 // For example, perform actions 10 times during the animation
    //
    //        let intervalDuration = animationDuration / TimeInterval(numberOfIntervals)
    //        var currentInterval = 0
    //
    //        let timer = Timer.scheduledTimer(withTimeInterval: intervalDuration, repeats: true) { timer in
    //            // Perform your action here at each interval
    //            print("Performing action at interval \(currentInterval + 5)")
    //            if self.statuss == true {
    //                self.activeRequest()
    //            } else {
    //                self.progressVw.isHidden = true
    //            }
    //            currentInterval += 1
    //            if currentInterval >= numberOfIntervals {
    //                timer.invalidate() // Stop the timer when all intervals are completed
    //            }
    //        }
    //
    //        UIView.animate(withDuration: animationDuration) {
    //            self.progressVw.setProgress(targetProgress, animated: true)
    //        }
    //    }
    
    func doStuff() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { timer in
            let change: Float = 0.01
            self.progressVw.progress = self.progressVw.progress + (change)
            if self.statuss == true {
                self.activeRequest()
            } else {
                self.timer?.invalidate()
            }
            if self.progressVw.progress >= 2.0 {
                self.timer?.invalidate()
            }
        })
    }
    
    func activeRequest()
    {
        Api.shared.getRequestDetails(self, self.param_Current_Req()) { responseData in
            let obj = responseData
            if obj.status == "Accept" {
                self.statuss = false
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserReqDetailVC") as! UserReqDetailVC
                vc.request_Id = responseData.id ?? ""
                vc.isFromNotification = true
                self.navigationController?.pushViewController(vc, animated: true)
            } else if obj.status == "Reject" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourBookingRequestDeclinedByTheProviderPleaseBookYourRequestWithOtherProviderThanks(), delegate: nil, parentViewController: self) { bool in
                    self.statuss = false
                    Switcher.checkLoginStatus()
                }
            }
        }
    }
    
    func param_Current_Req() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        dict["request_id"]             = request_Id as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        changeRequestStatus()
    }
    
    func changeRequestStatus()
    {
        Api.shared.changeRequestStatus(self, paramChangeStatus()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.bookingHasBeenCancelledSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.statuss = false
                Switcher.checkLoginStatus()
            }
        }
    }
    
    func paramChangeStatus() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["provider_id"]            = provider_Id as AnyObject
        dict["request_id"]             = request_Id as AnyObject
        dict["status"]                 = "Reject" as AnyObject
        dict["reason_title"]           = k.emptyString as AnyObject
        dict["reason_detail"]          = k.emptyString as AnyObject
        dict["cancelation_fee"]        = k.emptyString as AnyObject
        print(dict)
        return dict
    }
}

