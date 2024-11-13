//
//  ProviderRequestDtVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit

class ProviderRequestDtVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblNumProfession: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTimeSlot: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tblVwHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_AcceptOt: UIButton!
    @IBOutlet weak var btn_CancelOt: UIButton!
    @IBOutlet weak var btn_StackView: UIStackView!
    
    var requestId = ""
    var userId = ""
    var recieverId = ""
    var adminNumber = ""
    var user_Name = ""
    
    var arrServiceName: [Sub_Service_details] = []
    
    var isFromNotification:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "NewServiceCell", bundle: nil), forCellReuseIdentifier: "NewServiceCell")
        self.btn_StackView.isHidden = true
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.requestDetails(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.requestDetails()
    }
    
    override func leftClick() {
        if isFromNotification {
            Switcher.checkLoginStatus()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func requestDetails()
    {
        Api.shared.getRequestDetails(self, self.paramRequestDetail()) { responseData in
            let obj = responseData
            self.lblName.text = "\(obj.user_details?.first_name ?? "") \(obj.user_details?.last_name ?? "")"
            self.lblDate.text = obj.date ?? ""
            self.lblTimeSlot.text = obj.time_slot ?? ""
            self.txtAddress.text = obj.address ?? ""
            self.lblTotalAmount.text = "\(k.currency) \(obj.total_amount ?? "")"
            self.adminNumber = obj.provider_details?.mobile_with_code ?? ""
            self.userId = obj.user_id ?? ""
            self.user_Name = obj.user_details?.first_name ?? ""
            
            if Router.BASE_IMAGE_URL != obj.user_details?.image {
                Utility.setImageWithSDWebImage(obj.user_details?.image ?? "", self.img)
            } else {
                self.img.image = R.image.placeholder()
            }
            
            if let serviceObj = obj.service_details {
                if serviceObj.count > 0 {
                    self.arrServiceName = serviceObj
                } else {
                    self.arrServiceName = []
                }
                self.tblVwOt.reloadData()
            }
        }
    }
    
    func paramRequestDetail() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        dict["request_id"]             = requestId as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnChat(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.requestId = requestId
        vc.userName = user_Name
        vc.receiverId = userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
        let phoneNumber = self.adminNumber
        print(phoneNumber)// Replace with the contact number you want to open
        
        guard let url = URL(string: "tel://\(phoneNumber)") else {
            // Invalid URL
            // Handle the error condition here
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Device is not supporting the phone call!")
        }
    }
    
    func changeRequestStatus(_ userId: String,_ requestId: String,_ status: String,_ reason: String)
    {
        Api.shared.changeRequestStatus(self, paramChangeStatus(userId, requestId, status, reason)) { responseData in
            if status == R.string.localizable.accept() {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourBookingAcceptedSuccessfullly(), delegate: nil, parentViewController: self) { bool in
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.bookingHasBeenCancelledSuccessfully(), delegate: nil, parentViewController: self) { bool in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func paramChangeStatus(_ user_id: String,_ request_Id: String,_ status: String,_ cancelReason: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_id"]            = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["user_id"]                = user_id as AnyObject
        dict["request_id"]             = request_Id as AnyObject
        dict["status"]                 = status as AnyObject
        dict["reason_title"]           = cancelReason as AnyObject
        dict["reason_detail"]          = k.emptyString as AnyObject
        dict["cancelation_fee"]        = k.emptyString as AnyObject
        print(dict)
        return dict
    }
    
    
    @IBAction func btnAccept(_ sender: UIButton) {
        let status = "Accept"
        self.changeRequestStatus(userId, requestId, status, k.emptyString)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentCancelVC") as! PresentCancelVC
        vc.cloSubCancel = {(cancelReason) in
            let userId = self.userId
            let status = "Reject"
            self.changeRequestStatus(userId, self.requestId, status, cancelReason)
        }
        vc.isComingStatus = "PresentCancelVC"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension ProviderRequestDtVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrServiceName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewServiceCell", for: indexPath) as! NewServiceCell
        let obj = self.arrServiceName[indexPath.row]
        cell.lblServiceName.text = obj.service_name ?? ""
        cell.lblServicePrice.text = "\(k.currency) \(obj.service_rate ?? "")"
        self.tblVwHeight.constant = CGFloat(24 * self.arrServiceName.count)
        return cell
    }
}

extension ProviderRequestDtVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24
    }
}
