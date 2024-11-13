//
//  ProviderWalletVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit

class ProviderWalletVC: UIViewController {

    @IBOutlet weak var lblPendingStatus: UILabel!
    @IBOutlet weak var lblTotalEaring: UILabel!
    @IBOutlet weak var lblTotalEarning: UILabel!
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet weak var stack_View: UIStackView!
    
    var isComingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isComingFrom == "User" {
            self.stack_View.isHidden = true
        } else {
            self.stack_View.isHidden = false
        }
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.wallet(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.withdrawRequest()
        self.profile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func profile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.lblWalletBalance.text = "\(k.currency) \(obj.wallet ?? "0.0").0"
        }
    }
    
    func withdrawRequest()
    {
        Api.shared.withdrawRequest(self) { responseData in
            let obj = responseData
            self.lblTotalEarning.text = "\(k.currency) \(obj.amount ?? "0.0")"
            if obj.status == "Pending" {
                self.lblPendingStatus.text = "\(R.string.localizable.youHave1PendingWithdrawRequestFor()) \(k.currency) \(obj.amount ?? "")"
            } else {
                self.lblPendingStatus.text = R.string.localizable.noPendingRequestFound()
            }
        }
    }
    
    @IBAction func btnWithdraw(_ sender: UIButton) {
        Api.shared.withdrawRequest(self) { responseData in
            let obj = responseData
            if obj.status == "Pending" {
                self.alert(alertmessage: R.string.localizable.alreadyOneWithdrawRequestSent())
            } else {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProWalletAmountVC") as! ProWalletAmountVC
                vc.amount = obj.amount ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
