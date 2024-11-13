//
//  UserMyOrderVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class UserMyOrderVC: UIViewController {

    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnPending: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var table_View: UITableView!
    
    var arrBookingStatus: [Res_BookingStatus] = []
    var request_Status = "Accept"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table_View.register(UINib(nibName: "AcceptedCell", bundle: nil), forCellReuseIdentifier: "AcceptedCell")
        self.table_View.register(UINib(nibName: "PendingCell", bundle: nil), forCellReuseIdentifier: "PendingCell")
        self.table_View.register(UINib(nibName: "CompleteCell", bundle: nil), forCellReuseIdentifier: "CompleteCell")
        
        k.topMargin = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0) + 100
        self.btnAccept.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnAccept.setTitleColor(.white, for: .normal)
        self.btnPending.backgroundColor = .white
        self.btnPending.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnHistory.backgroundColor = .white
        self.btnHistory.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
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
        self.setNavigationBarItem(LeftTitle: R.string.localizable.myBookings(), LeftImage: "", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.GetBookingStaus()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAccepted(_ sender: UIButton) {
        self.btnAccept.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnAccept.setTitleColor(.white, for: .normal)
        self.btnPending.backgroundColor = .white
        self.btnPending.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnHistory.backgroundColor = .white
        self.btnHistory.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        request_Status = "Accept"
        self.GetBookingStaus()
    }
    
    @IBAction func btnPending(_ sender: UIButton) {
        self.btnAccept.backgroundColor = .white
        self.btnAccept.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnPending.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnPending.setTitleColor(.white, for: .normal)
        self.btnHistory.backgroundColor = .white
        self.btnHistory.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        request_Status = "Pending"
        self.GetBookingStaus()
    }
    
    @IBAction func btnHistory(_ sender: UIButton) {
        self.btnAccept.backgroundColor = .white
        self.btnAccept.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnPending.backgroundColor = .white
        self.btnPending.setTitleColor(hexStringToUIColor(hex: "#545454"), for: .normal)
        self.btnHistory.backgroundColor = hexStringToUIColor(hex: "#545454")
        self.btnHistory.setTitleColor(.white, for: .normal)
        request_Status = "Complete"
        self.GetBookingStaus()
    }
}

extension UserMyOrderVC {
    
    func GetBookingStaus() {
        Api.shared.getBookingStatus(self, paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrBookingStatus = responseData
            } else {
                self.arrBookingStatus = []
            }
            self.table_View.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject] {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["status"]                 = request_Status as AnyObject
        print(dict)
        return dict
    }
    
    func WebRequestStatus(_ userId: String,_ requestId: String,_ status: String,_ reason: String)
    {
        Api.shared.changeRequestStatus(self, paramChangeStatus(userId, requestId, status, reason)) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.bookingHasBeenCancelledSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.GetBookingStaus()
                self.dismiss(animated: true)
            }
        }
    }
    
    func paramChangeStatus(_ provider_Id: String,_ request_Id: String,_ status: String,_ cancelReason: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["provider_id"]            = provider_Id as AnyObject
        dict["request_id"]             = request_Id as AnyObject
        dict["status"]                 = status as AnyObject
        dict["reason_title"]           = cancelReason as AnyObject
        dict["reason_detail"]          = k.emptyString as AnyObject
        dict["cancelation_fee"]        = k.emptyString as AnyObject
        print(dict)
        return dict
    }
    
}

extension UserMyOrderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrBookingStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if request_Status == "Accept" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcceptedCell", for: indexPath) as! AcceptedCell
            
            let obj = self.arrBookingStatus[indexPath.row]
            
            cell.lblName.text = "\(obj.provider_details?.first_name ?? "") \(obj.provider_details?.last_name ?? "") (\(obj.provider_details?.store_name ?? ""))"
            cell.lblDateTime.text = "\(obj.date ?? "") \(obj.time_slot ?? "")"
            cell.lblAddress.text = obj.address ?? ""
            cell.lblStoreService.text = "Service For : \(obj.service_name ?? "")"
            cell.lblPrice.text = "\(k.currency) \(obj.total_amount_with_admin_service ?? "")"
            if Router.BASE_IMAGE_URL != obj.provider_details?.image {
                Utility.setImageWithSDWebImage(obj.provider_details?.image ?? "", cell.img)
            } else {
                cell.img.image = R.image.placeholder_2()
            }
            
            let provider_Status = obj.status
            switch provider_Status {
            case "Accept":
                cell.lbl_ProviderStatus.text = R.string.localizable.accepted()
                cell.btnCancelOt.isHidden = false
                cell.btn_Temp.isHidden = true
            case "OnTheWay":
                cell.lbl_ProviderStatus.text =  R.string.localizable.yourProfessionalIsOnTheWay()
                cell.btnCancelOt.isHidden = false
                cell.btn_Temp.isHidden = true
            case "Arrived":
                cell.lbl_ProviderStatus.text =  R.string.localizable.yourProfessionalArrivedOnYourLocation()
                cell.btnCancelOt.isHidden = false
                cell.btn_Temp.isHidden = true
            case "Start":
                cell.lbl_ProviderStatus.text = R.string.localizable.yourProfessionalStartWork()
                cell.btnCancelOt.isHidden = true
                cell.btn_Temp.isHidden = false
            default:
                cell.lbl_ProviderStatus.text = R.string.localizable.completed()
                cell.btnCancelOt.isHidden = true
                cell.btn_Temp.isHidden = false
            }
            
            cell.cloChat = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
                vc.requestId = obj.id ?? ""
                vc.receiverId = obj.provider_id ?? ""
                vc.userName = "\(obj.provider_details?.first_name ?? "") \(obj.provider_details?.last_name ?? "")"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            cell.cloCancel = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentCancelVC") as! PresentCancelVC
                vc.cloSubCancel = {(cancelReason) in
                    let providerId = obj.provider_id ?? ""
                    let requestId = obj.id ?? ""
                    let status = "Reject"
                    self.WebRequestStatus(providerId, requestId, status, cancelReason)
                }
                vc.isComingStatus = obj.status ?? ""
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
            
            return cell
        } else if request_Status == "Pending" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PendingCell", for: indexPath) as! PendingCell
        
            let obj = self.arrBookingStatus[indexPath.row]
            cell.lblName.text = "\(obj.provider_details?.first_name ?? "") \(obj.provider_details?.last_name ?? "") (\(obj.provider_details?.store_name ?? ""))"
            cell.lblDateTime.text = "\(obj.date ?? "") \(obj.time_slot ?? "")"
            cell.lblAddress.text = obj.address ?? ""
            cell.lblStoreService.text = "\(R.string.localizable.serviceFor()) \(obj.service_name ?? "")"
            cell.lblPrice.text = "\(k.currency) \(obj.total_amount_with_admin_service ?? "")"
            if Router.BASE_IMAGE_URL != obj.provider_details?.image {
                Utility.setImageWithSDWebImage(obj.provider_details?.image ?? "", cell.img)
            } else {
                cell.img.image = R.image.placeholder_2()
            }
            
            cell.cloCancel = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentCancelVC") as! PresentCancelVC
                vc.cloSubCancel = {(cancelReason) in
                    let providerId = obj.provider_id ?? ""
                    let requestId = obj.id ?? ""
                    let status = "Reject"
                    self.WebRequestStatus(providerId, requestId, status, cancelReason)
                }
                vc.isComingStatus = "PresentCancelVC"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteCell", for: indexPath) as! CompleteCell
            
            let obj = self.arrBookingStatus[indexPath.row]
            cell.lblName.text = "\(obj.provider_details?.first_name ?? "") \(obj.provider_details?.last_name ?? "") (\(obj.provider_details?.store_name ?? ""))"
            cell.lblDateTime.text = "\(obj.date ?? "") \(obj.time_slot ?? "")"
            cell.lblAddress.text = obj.address ?? ""
            cell.lblStoreService.text = obj.service_for ?? ""
            cell.lblPrice.text = "\(k.currency) \(obj.total_amount_with_admin_service ?? "")"
            
            if Router.BASE_IMAGE_URL != obj.provider_details?.image {
                Utility.setImageWithSDWebImage(obj.provider_details?.image ?? "", cell.img)
            } else {
                cell.img.image = R.image.placeholder_2()
            }
            
            if obj.rating_review_status == "YES" {
                cell.btnGiveRatingOt.isHidden = true
                cell.btn_TempOt.isHidden = false
            } else {
                cell.btnGiveRatingOt.isHidden = false
                cell.btn_TempOt.isHidden = true
            }
            
            cell.cloGiveRating = {() in
                let vc = R.storyboard.main().instantiateViewController(withIdentifier: "GiveRatingVC") as! GiveRatingVC
                vc.providerId = obj.provider_id ?? ""
                vc.reqId = obj.id ?? ""
                vc.cloRefresh = {() in
                    self.GetBookingStaus()
                }
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        }
    }
}

extension UserMyOrderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if request_Status != "Complete" {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "UserReqDetailVC") as! UserReqDetailVC
            vc.request_Id = self.arrBookingStatus[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
