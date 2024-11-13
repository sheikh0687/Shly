//
//  ProviderManageProfileVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import DropDown

class ProviderManageProfileVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var btnProviderImg: UIButton!
    @IBOutlet weak var btnCoverImg: UIButton!
    @IBOutlet weak var txtProviderName: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtHomeFess: UITextField!
    @IBOutlet weak var txtAboutUs: UITextView!
    @IBOutlet weak var tableheight: NSLayoutConstraint!
    @IBOutlet weak var btnTimeDrop: UIButton!
    
    var addressVal = ""
    var lat = 0.0
    var lon = 0.0
    
    var imageStoreLogo = UIImage()
    var imageProviderCover = UIImage()
    
    var arrTimeSlot: [Store_day_details] = []
    
    var openCloseStatus = [String]()
    var openDay = [String]()
    var openTime = [String]()
    var closeTime = [String]()
    
    var language = ""
    var dropDown = DropDown()
    
    var selected_Time = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVw.register(UINib(nibName: "ProviderTimeSlotCell", bundle: nil), forCellReuseIdentifier: "ProviderTimeSlotCell")
        self.language = k.userDefault.value(forKey: k.session.language) as? String ?? ""
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.manageProfile(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.getProviderDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnProviderImg(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.imageStoreLogo = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnCoverImg(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.imageProviderCover = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnAddressPicker(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { addressCordinate, latVal, lonVal, addressVal in
            self.txtAddress.text = addressVal
            self.addressVal = addressVal
            self.lat = latVal
            self.lon = lonVal
        }
        vc.is_Coming = "ProviderManageProfileVC"
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btn_SelectTime(_ sender: UIButton) {
        dropDown.anchorView = sender
        dropDown.dataSource = ["30 min","45 min","60 min","90 min","120 min"]
        dropDown.show()
        dropDown.bottomOffset = CGPoint(x: 0, y: 45)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selected_Time = item
            print(self.selected_Time)
            sender.setTitle(item, for: .normal)
        }
    }
    
    
    func getProviderDetails()
    {
        Api.shared.getProviderDetail(self, paramDetails()) { responseData in
            let obj = responseData
            self.txtProviderName.text = obj.store_name ?? ""
            self.txtAddress.text = obj.address ?? ""
            self.txtHomeFess.text = obj.home_service_fee ?? ""
            self.txtAboutUs.text = obj.about_store ?? ""
            self.addressVal = obj.address ?? ""
            self.btnTimeDrop.setTitle(obj.interval_time ?? "", for: .normal)
            
            if Router.BASE_IMAGE_URL != obj.store_logo {
                Utility.downloadImageBySDWebImage(obj.store_logo ?? "") { image, error in
                    if error == nil {
                        self.btnProviderImg.setImage(image, for: .normal)
                    } else {
                        self.btnProviderImg.setImage(R.image.placeholder_2(), for: .normal)
                    }
                }
            } else {
                self.btnProviderImg.setImage(R.image.placeholder_2(), for: .normal)
            }
            
            if Router.BASE_IMAGE_URL != obj.store_cover_image {
                Utility.downloadImageBySDWebImage(obj.store_cover_image ?? "") { image, error in
                    if error == nil {
                        self.btnCoverImg.setImage(image, for: .normal)
                    } else {
                        self.btnCoverImg.setImage(R.image.placeholder_2(), for: .normal)
                    }
                }
            } else {
                self.btnCoverImg.setImage(R.image.placeholder_2(), for: .normal)
            }
            
            if let objStore = obj.store_day_details {
                if objStore.count > 0 {
                    self.arrTimeSlot = objStore
                    self.tableheight.constant = CGFloat(self.arrTimeSlot.count * 45)
                } else {
                    self.arrTimeSlot = []
                    self.tableheight.constant = 0
                }
                self.tblVw.reloadData()
                print(responseData)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_id"]            = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        print(dict)
        return dict
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        if txtProviderName.hasText && txtAddress.hasText && txtHomeFess.hasText && txtAboutUs.hasText && selected_Time != "" {
            self.updateProviderInfo()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func updateProviderInfo()
    {
        Api.shared.updatedProviderProfile(self, updateParamDetails(), images: updateImageParam(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.profileUpdatedSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.getProviderDetails()
            }
        }
    }
    
    func updateParamDetails() -> [String : String]
    {
        var dict: [String : String]        = [:]
        dict["user_id"]                    = k.userDefault.value(forKey: k.session.userId) as? String
        dict["store_name"]                 = self.txtProviderName.text
        dict["about_store"]                = self.txtAboutUs.text
        dict["address"]                    = self.addressVal
        dict["lat"]                        = String(self.lat)
        dict["lon"]                        = String(self.lon)
        dict["interval_time"]              = self.selected_Time
        dict["store_ope_closs_status"]     = self.openCloseStatus.joined(separator: ",")
        dict["open_day"]                   = self.openDay.joined(separator: ",")
        dict["open_time"]                  = self.openTime.joined(separator: ",")
        dict["close_time"]                 = self.closeTime.joined(separator:  ",")
        dict["home_service"]               = k.emptyString
        dict["allow_reward_point"]         = k.emptyString
        dict["reward_point"]               = k.emptyString
        dict["reward_point_value"]         = k.emptyString
        dict["home_service_fee"]           = self.txtHomeFess.text
        print(dict)
        return dict
    }
    
    func updateImageParam() -> [String : UIImage]
    {
        var dict: [String : UIImage] = [:]
        dict["store_logo"]           = self.imageStoreLogo
        dict["store_cover_image"]    = self.imageProviderCover
        print(dict)
        return dict
    }
}

extension ProviderManageProfileVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTimeSlot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderTimeSlotCell", for: indexPath) as! ProviderTimeSlotCell
        
        let obj = self.arrTimeSlot[indexPath.row]
        
        if language == "english" {
            print(obj.open_day ?? "")
            cell.lblDay.text = obj.open_day ?? ""
        } else {
            print("\(obj.open_day ?? "") Open day for else")
            switch obj.open_day {
            case "Monday":
                cell.lblDay.text = "Lundi"
            case "Tuesday":
                cell.lblDay.text = "Mardi"
            case "Wednesday":
                cell.lblDay.text = "Mercredi"
            case "Thursday":
                cell.lblDay.text = "Jeudi"
            case "Friday":
                cell.lblDay.text = "Vendredi"
            case "Saturday":
                cell.lblDay.text = "Samedi"
            default:
                cell.lblDay.text = "Dimanche"
                break
            }
        }
        
        cell.btnOpenTime.setTitle(obj.open_time ?? "", for: .normal)
        if obj.close_time == "24:00" {
            cell.btnCloseTime.setTitle("00:00", for: .normal)
        } else {
            cell.btnCloseTime.setTitle(obj.close_time ?? "", for: .normal)
        }
        
        if language == "english" {
            cell.btnStatusOt.setTitle(obj.store_ope_closs_status ?? "", for: .normal)
        } else {
            switch obj.store_ope_closs_status {
            case "OPEN":
                cell.btnStatusOt.setTitle("OUVERT", for: .normal)
            default:
                cell.btnStatusOt.setTitle("FERME", for: .normal)
                break
            }
        }
        
        let storeStatus = self.arrTimeSlot.map({ $0.store_ope_closs_status ?? ""})
        print(storeStatus)
        self.openCloseStatus = storeStatus
        
        let openDayStatus = self.arrTimeSlot.map({ $0.open_day ?? ""})
        print(openDayStatus)
        self.openDay = openDayStatus
        
        let openTimeStatus = self.arrTimeSlot.map({ $0.open_time ?? ""})
        print(openTimeStatus)
        self.openTime = openTimeStatus
        
        let closeTimeStatus = self.arrTimeSlot.map({ $0.close_time ?? ""})
        print(closeTimeStatus)
        self.closeTime = closeTimeStatus
        
        if obj.store_ope_closs_status != "OPEN" {
            cell.btnStatusOt.backgroundColor = .lightGray
        } else {
            cell.btnStatusOt.backgroundColor = hexStringToUIColor(hex: "#15B67C")
        }
        
        cell.cloStatus = { (statuss) in
            self.openCloseStatus[indexPath.row] = statuss
            print(self.openCloseStatus[indexPath.row])
        }
        
        cell.cloOpenTime = {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProChooseTimeVC") as! ProChooseTimeVC
            vc.cloTimeSlot = {(time) in
                cell.btnOpenTime.setTitle(time, for: .normal)
                self.openTime[indexPath.row] = time
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        cell.cloCloseTime = {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProChooseTimeVC") as! ProChooseTimeVC
            vc.cloTimeSlot = {(time) in
                var modifiedTime = time
                if modifiedTime == "00:00" {
                    modifiedTime = "24:00"
                    self.closeTime[indexPath.row] = modifiedTime
                    print(self.closeTime[indexPath.row])
                    cell.btnCloseTime.setTitle("00:00", for: .normal)
                } else {
                    self.closeTime[indexPath.row] = modifiedTime
                    cell.btnCloseTime.setTitle(modifiedTime, for: .normal)
                }
            }
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        return cell
    }
}

extension ProviderManageProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
