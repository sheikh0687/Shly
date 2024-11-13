//
//  BookingRequestVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit
import FSCalendar

class BookingRequestVC: UIViewController, UIGestureRecognizerDelegate,FSCalendarDataSource, FSCalendarDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calenderHeight: NSLayoutConstraint!
    @IBOutlet weak var timeSlotCollection: UICollectionView!
    @IBOutlet weak var vwHide: UIStackView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var constraintHeightTimeSlot: NSLayoutConstraint!
    
    var providerId = ""
    var selectedTimeSlot = ""
    var selectedCatId = ""
    var selectedCatName = ""
    var selectedDateStr = ""
    
    var selectedDate = [String]()
    var serviceId: [Int] = []
    var serviceName: [String] = []
    var servicePrice: [String] = []
    var admin_ServiceFee: [Int] = []
    
    var arrContainData: [dataModel] = []
    var arrTimeSlot: [Res_TimeSlot] = []
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let language = k.userDefault.value(forKey: k.session.language) as? String {
            if language == "english" {
                calendar.locale = Locale(identifier: "en_US")
            } else {
                calendar.locale = Locale(identifier: "fr")
            }
        }
        self.txtDescription.addHint(R.string.localizable.enter())
        for (name, price) in zip(serviceName, servicePrice) {
            let data = dataModel(selectedName: name, selectedPrice: price)
            arrContainData.append(data)
        }
        self.timeSlotCollection.register(UINib(nibName: "TimeSlotCell", bundle: nil),forCellWithReuseIdentifier: "TimeSlotCell")
        self.timeSlotCollection.allowsSelection = true
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calenderHeight.constant = 400
        }
        
        self.calendar.select(Date())
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .week
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        self.timeSlot(Utility.getCurrentDate(), Utility.getCurrentDay())
    }
    
    deinit {
        print("\(#function)")
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calenderHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd" // Set the desired date format
        
        self.selectedDateStr = dateFormatter.string(from: date)
        var selectedDayOfWeek: String?
        
        // If the user did not select a date, use the current date
        if selectedDateStr.isEmpty {
            let currentDate = Date()
            selectedDateStr = dateFormatter.string(from: currentDate)
            selectedDayOfWeek = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: currentDate) - 1]
        } else {
            selectedDayOfWeek = dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        }
        
        print("Selected date is \(selectedDateStr)")
        print("Selected day of the week is \(selectedDayOfWeek ?? "N/A")")
        
        self.timeSlot(selectedDateStr, selectedDayOfWeek ?? "")
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.bookingRequest(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnConfirmBooking(_ sender: UIButton) {
        print(selectedTimeSlot)
        if selectedTimeSlot == "" {
            self.alert(alertmessage: R.string.localizable.pleaseSelectTheTimeSlot())
        } else {
            let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ConfirmBookingVC") as! ConfirmBookingVC
            vc.arrValues = arrContainData
            vc.timeSlot = self.selectedTimeSlot
            vc.providerId = self.providerId
            vc.selectedServiceId = self.serviceId
            vc.selectedServiceName = self.serviceName
            vc.selectedServicePrice = self.servicePrice
            vc.selected_AdminFee = self.admin_ServiceFee
            vc.catId = self.selectedCatId
            vc.catName = self.selectedCatName
            if self.selectedDateStr == "" {
                vc.date = Utility.getCurrentDate()
            } else {
                vc.date = self.selectedDateStr
            }
            vc.descriptionVal = self.txtDescription.text
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func timeSlot(_ currentTime: String, _ currentDay: String) {
        Api.shared.getTimeSlot(self, self.paramDetails(currentTime, currentDay)) { responseData in
            self.arrTimeSlot = responseData
            print(responseData.count)
            let numberOfItemsInRow = 3 // You can adjust this based on your layout
            let numberOfRows = (responseData.count + numberOfItemsInRow - 1) / numberOfItemsInRow
            let cellHeight: CGFloat = 36
            self.constraintHeightTimeSlot.constant = CGFloat(numberOfRows) * cellHeight
            self.vwHide.isHidden = responseData.isEmpty
            self.timeSlotCollection.reloadData()
        }
    }
    
    func paramDetails(_ currentAndSelectedDate: String,_ currentAndSelectedDay: String) -> [String : AnyObject]
    {
        var dict : [String : AnyObject] = [:]
        dict["user_id"]                 = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["saloon_id"]               = self.providerId as AnyObject
        dict["now_current_day"]         = currentAndSelectedDay as AnyObject
        dict["current_date"]            = currentAndSelectedDate as AnyObject
        print(dict)
        return dict
    }
}

extension BookingRequestVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrTimeSlot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeSlotCell", for: indexPath) as! TimeSlotCell
        let obj = self.arrTimeSlot[indexPath.row]
        cell.lbl_Time.text = obj.time_slot ?? ""
        if obj.time_slot_status == "No" {
            cell.cornerRadius = 10
            cell.borderWidth = 0.5
            cell.borderColor = .red
            cell.backgroundColor = .clear
        } else {
            cell.backgroundColor = .clear
            cell.cornerRadius = 10
            cell.borderWidth = 0.5
            cell.borderColor = .separator
        }
        return cell
    }
}

extension BookingRequestVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/3 - 5, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension BookingRequestVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TimeSlotCell
        let obj = arrTimeSlot[indexPath.item]
        
        if obj.time_slot_status == "No" {
            self.alert(alertmessage: R.string.localizable.thisTimeSlotIsAlreadyBookedBySomeone())
        } else {
            cell.backgroundColor = .darkGray
            self.selectedTimeSlot = obj.time_slot ?? ""
            print(self.selectedTimeSlot)
        }
        
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPathOth in indexPaths {
            if indexPathOth.item != indexPath.item && indexPathOth.section == indexPath.section {
                if let cell1 = collectionView.cellForItem(at: indexPathOth) as? TimeSlotCell {
                    cell1.backgroundColor = .clear
                }
            }
        }
    }
}
