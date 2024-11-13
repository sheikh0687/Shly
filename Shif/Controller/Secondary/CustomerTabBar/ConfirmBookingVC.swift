//
//  ConfirmBookingVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit

class ConfirmBookingVC: UIViewController {

    @IBOutlet weak var lblTimeSlot: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var tblVwOt: UITableView!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtCardNumber: UITextView!
    @IBOutlet weak var tblVwHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl_AdminServiceFee: UILabel!
    @IBOutlet weak var lbl_ServiceTotal: UILabel!
    
    var timeSlot = ""
    var date = ""
    var providerId = ""
    var descriptionVal = ""
    var catId = ""
    var catName = ""
    
    var addressVal = ""
    var addressId = ""
    var latVal = 0.0
    var lonVal = 0.0
    
    var totalPrice = 0
    var total_AdminFeeCal = 0
    var final_TotalAmount = ""
    
    var card_Id = ""
    var card_Brand = ""
    var card_LastFour = ""
    
    var arrValues = [dataModel]()
    var selectedServiceId: [Int] = []
    var selectedServiceName: [String] = []
    var selectedServicePrice: [String] = []
    var selected_AdminFee: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "NewServiceCell", bundle: nil), forCellReuseIdentifier: "NewServiceCell")
        self.lblTimeSlot.text = self.timeSlot
        self.lblDate.text = self.date
        
        total_AdminFeeCal = selected_AdminFee.reduce(0, +)
        self.lbl_AdminServiceFee.text = "\(k.currency) \(total_AdminFeeCal)"
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        final_TotalAmount = String(total_AdminFeeCal + totalPrice)
        self.lblTotalAmount.text = "\(k.currency) \(final_TotalAmount)"
    }
    
    @IBAction func btnAddress(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        vc.cloSelectAddress = { (address, lat, lon, id) in
            self.txtAddress.text = address
            self.addressVal = address
            self.addressId = id
            self.latVal = lat
            self.lonVal = lon
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPayCard(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "SavedCardVC") as! SavedCardVC
        vc.cloCardDetail = {(cardId, cardBrand, cardLastFour) in
            self.txtCardNumber.text = "\(cardBrand)  **** **** **** \(cardLastFour)"
            self.card_Id = cardId
            self.card_Brand = cardBrand
            self.card_LastFour = cardLastFour
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPayNow(_ sender: UIButton) {
        if self.txtAddress.hasText && self.txtCardNumber.hasText {
            addBooking()
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func addBooking()
    {
        Api.shared.addBooking(self, self.paramDetails()) { responseData in
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PresentConfirmationVC") as! PresentConfirmationVC
            vc.request_Id = responseData.id ?? ""
            vc.provider_Id = self.providerId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject]           = [:]
        dict["user_id"]                          = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["customer_id"]                      = k.userDefault.value(forKey: k.session.customerId) as AnyObject
        dict["provider_id"]                      = providerId as AnyObject
        dict["service_id"]                       = selectedServiceId.map { String($0) }.joined(separator: ",") as AnyObject
        dict["service_name"]                     = selectedServiceName.joined(separator: ",") as AnyObject
        dict["price"]                            = selectedServicePrice.joined(separator: ",") as AnyObject
        dict["total_amount"]                     = totalPrice as AnyObject
        dict["total_amount_with_admin_service"]  = final_TotalAmount as AnyObject
        dict["total_admin_service_fee"]          = selected_AdminFee.map { String($0) }.joined(separator: ",") as AnyObject
        dict["sub_amount"]                       = totalPrice as AnyObject
        dict["date"]                             = date as AnyObject
        dict["time"]                             = k.emptyString as AnyObject
        dict["service_for"]                      = "Salon" as AnyObject
        dict["time_slot"]                        = timeSlot as AnyObject
        dict["emp_id"]                           = k.emptyString as AnyObject
        dict["emp_name"]                         = k.emptyString as AnyObject
        dict["address"]                          = addressVal as AnyObject
        dict["address_id"]                       = addressId as AnyObject
        dict["description"]                      = descriptionVal as AnyObject
        dict["offer_id"]                         = k.emptyString as AnyObject
        dict["offer_code"]                       = k.emptyString as AnyObject
        dict["lat"]                              = self.latVal as AnyObject
        dict["lon"]                              = self.lonVal as AnyObject
        dict["timezone"]                         = localTimeZoneIdentifier as AnyObject
        dict["use_reward_point"]                 = "0" as AnyObject
        dict["use_reward_discount"]              = k.emptyString as AnyObject
        dict["discount"]                         = k.emptyString as AnyObject
        dict["payment_type"]                     = "Card" as AnyObject
        dict["cat_id"]                           = self.catId as AnyObject
        dict["cat_name"]                         = self.catName as AnyObject
        dict["card_id"]                          = self.card_Id as AnyObject
        dict["card_last_four"]                   = self.card_LastFour as AnyObject
        dict["card_brand"]                       = self.card_Brand as AnyObject
        print(dict)
        return dict
    }
}

extension ConfirmBookingVC: UITableViewDataSource 
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewServiceCell", for: indexPath) as! NewServiceCell
        cell.lblServiceName.text = self.arrValues[indexPath.row].selectedName
        cell.lblServicePrice.text = "\(k.currency) \(self.arrValues[indexPath.row].selectedPrice)"
        
        if let cellPriceText = cell.lblServicePrice.text,
           let cellPrice = Int(cellPriceText.replacingOccurrences(of: "\(k.currency) ", with: "")) {
            totalPrice += cellPrice
        }
        
        self.lbl_ServiceTotal.text = "\(k.currency) \(totalPrice)"
        
        self.tblVwHeight.constant = CGFloat(24 * self.arrValues.count)
        return cell
    }
}

extension ConfirmBookingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 24
    }
}
