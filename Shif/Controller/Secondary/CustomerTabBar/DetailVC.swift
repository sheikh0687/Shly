//
//  DetailVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var btnServiceOt: UIButton!
    @IBOutlet weak var btnAboutOt: UIButton!
    @IBOutlet weak var btnGallaryOt: UIButton!
    @IBOutlet weak var btnReviewOt: UIButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var serviceVw: UIView!
    @IBOutlet weak var aboutVw: UIView!
    @IBOutlet weak var gallaryVw: UIView!
    @IBOutlet weak var reviewVw: UIView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblHired: UILabel!
    @IBOutlet weak var containerVwHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var reqId = ""
    var catId = ""
    var catName = ""
    var arrGallary: [Gallary_Provider_images] = []
    
    var selectedId: [Int] = []
    var selectedPrice: [String] = []
    var selectedName: [String] = []
    var selected_AdminFee: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnServiceOt.setTitleColor(.darkGray, for: .normal)
        btnAboutOt.setTitleColor(.lightGray, for: .normal)
        btnGallaryOt.setTitleColor(.lightGray, for: .normal)
        btnReviewOt.setTitleColor(.lightGray, for: .normal)
        lbl1.backgroundColor = .black
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        serviceVw.isHidden = false
        aboutVw.isHidden = true
        gallaryVw.isHidden = true
        reviewVw.isHidden = true
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.details(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        GetServiceDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
        
    func GetServiceDetails()
    {
        Api.shared.getProviderDetail(self, self.paramDetails()) { responseData in
            let obj = responseData
            self.lblStoreName.text = obj.store_name ?? ""
            self.lblRating.text = "\(obj.rating ?? "")(\(obj.rating_count ?? 0))"
            
            if Router.BASE_IMAGE_URL != obj.store_cover_image {
                Utility.setImageWithSDWebImage(obj.store_cover_image ?? "", self.img)
            } else {
                self.img.image = R.image.placeholder_2()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContServiceVC" {
           if let vc = segue.destination as? ContServiceVC {
               vc.providerId = self.reqId
               print(vc.providerId)
               vc.scrollView = self.scrollview
               vc.cloServices = {(selectedId, selectedName, selectedPrice, admin_Fee) in
                   self.selectedId = selectedId
                   self.selectedName = selectedName
                   self.selectedPrice = selectedPrice
                   self.selected_AdminFee = admin_Fee
               }
            }
        }
        
        if segue.identifier == "ContGallaryVC" {
            if let vc = segue.destination as? ContGallaryVC {
                vc.providerId = self.reqId
            }
        }
        
        if segue.identifier == "ContReviewVC" {
            if let vc = segue.destination as? ContReviewVC {
                vc.providerID = self.reqId
            }
        }
        
        if segue.identifier == "ContAboutVC" {
            if let vc = segue.destination as? ContAboutVC {
                vc.reqId = self.reqId
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject]     = [:]
        dict["provider_id"]                = self.reqId as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnService(_ sender: UIButton) {
        btnServiceOt.setTitleColor(.darkGray, for: .normal)
        btnAboutOt.setTitleColor(.lightGray, for: .normal)
        btnGallaryOt.setTitleColor(.lightGray, for: .normal)
        btnReviewOt.setTitleColor(.lightGray, for: .normal)
        lbl1.backgroundColor = .black
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        serviceVw.isHidden = false
        aboutVw.isHidden = true
        gallaryVw.isHidden = true
        reviewVw.isHidden = true
    }
    
    @IBAction func btnAbout(_ sender: UIButton) {
        btnServiceOt.setTitleColor(.lightGray, for: .normal)
        btnAboutOt.setTitleColor(.darkGray, for: .normal)
        btnGallaryOt.setTitleColor(.lightGray, for: .normal)
        btnReviewOt.setTitleColor(.lightGray, for: .normal)
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .black
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        serviceVw.isHidden = true
        aboutVw.isHidden = false
        gallaryVw.isHidden = true
        reviewVw.isHidden = true
    }
    
    @IBAction func btnGallary(_ sender: UIButton) {
        btnServiceOt.setTitleColor(.lightGray, for: .normal)
        btnAboutOt.setTitleColor(.lightGray, for: .normal)
        btnGallaryOt.setTitleColor(.darkGray, for: .normal)
        btnReviewOt.setTitleColor(.lightGray, for: .normal)
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .black
        lbl4.backgroundColor = .white
        serviceVw.isHidden = true
        aboutVw.isHidden = true
        gallaryVw.isHidden = false
        reviewVw.isHidden = true
    }
    
    @IBAction func btnReviews(_ sender: UIButton) {
        btnServiceOt.setTitleColor(.lightGray, for: .normal)
        btnAboutOt.setTitleColor(.lightGray, for: .normal)
        btnGallaryOt.setTitleColor(.lightGray, for: .normal)
        btnReviewOt.setTitleColor(.darkGray, for: .normal)
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .black
        serviceVw.isHidden = true
        aboutVw.isHidden = true
        gallaryVw.isHidden = true
        reviewVw.isHidden = false
    }
    
    @IBAction func btnBook(_ sender: UIButton) {
        if Utility.isUserLogin() {
            if self.selectedId.isEmpty {
                self.alert(alertmessage: R.string.localizable.pleaseSelectTheService())
            } else {
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "BookingRequestVC") as! BookingRequestVC
                vc.serviceId = self.selectedId
                vc.serviceName = self.selectedName
                vc.servicePrice = self.selectedPrice
                vc.admin_ServiceFee = self.selected_AdminFee
                vc.providerId = self.reqId
                vc.selectedCatId = self.catId
                vc.selectedCatName = self.catName
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
