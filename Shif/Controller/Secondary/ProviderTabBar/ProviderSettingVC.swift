//
//  ProviderSettingVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit

class ProviderSettingVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = hexStringToUIColor(hex: "#FAFAFA")
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: R.string.localizable.settings(), LeftImage: "", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.providerProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func providerProfile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.lblName.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
            self.lblMobile.text = obj.mobile ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image ?? "" {
                Utility.setImageWithSDWebImage(obj.image ?? "", self.img)
            } else {
                self.img.image = R.image.profile_ic()
            }
        }
    }
    
    @IBAction func btnUpdateProfile(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ManageProfileVC") as! ManageProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnWallet(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderWalletVC") as! ProviderWalletVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMyService(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderMyServiceVC") as! ProviderMyServiceVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnGallary(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderGallaryVC") as! ProviderGallaryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnChangeLanguage(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderChangeLanguageVC") as! ProviderChangeLanguageVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnInviteFrnd(_ sender: UIButton) {
        Utility.doShare("www.google.com", "www.google.com", self)
    }
    
    @IBAction func btn_MyReviews(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "MyReviewVC") as! MyReviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnTermCondition(_ sender: UIButton)
    {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ConditionAndPolicyVC") as! ConditionAndPolicyVC
        vc.which_Is = "TermAndCondition"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: UIButton)
    {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ConditionAndPolicyVC") as! ConditionAndPolicyVC
        vc.which_Is = "PrivacyPolicy"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnContact(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnDeleteAccount(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentDeleteVC") as! PresentDeleteVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        isLogout = true
        UserDefaults.standard.removeObject(forKey: k.session.userId)
        UserDefaults.standard.synchronize()
        Switcher.checkLoginStatus()
    }
}
