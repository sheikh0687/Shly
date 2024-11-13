//
//  EditProfileVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit
import CountryPickerView

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountryPicker: UITextField!
    @IBOutlet weak var btnImg: UIButton!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountryView()
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.editProfile(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        GetProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 40, height: 16))
        cp.flagImageView.isHidden = true    
        txtCountryPicker.rightView = cp
        txtCountryPicker.rightViewMode = .always
        self.cpvTextField = cp
        let countryCode = "FR"
        self.cpvTextField.setCountryByCode(countryCode)
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "JosefinSans-Regular", size: 14.0)
        cp.countryDetailsLabel.textColor = .gray
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    func GetProfile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.txtFirstName.text = obj.first_name ?? ""
            self.txtLastName.text = obj.last_name ?? ""
            self.txtMobile.text = obj.mobile ?? ""
            self.txtCountryPicker.text = obj.mobile_with_code ?? ""
            self.txtEmail.text = obj.email ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image ?? "" {
                Utility.downloadImageBySDWebImage(obj.image ?? "") { image, error in
                    if error == nil {
                        self.btnImg.setImage(image, for: .normal)
                    } else {
                        self.btnImg.setImage(R.image.profile_ic(), for: .normal)
                    }
                }
            } else {
                self.btnImg.setImage(R.image.profile_ic(), for: .normal)
            }
        }
    }
    
    @IBAction func btnTappedCamera(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        if self.txtEmail.hasText && self.txtFirstName.hasText && self.txtLastName.hasText && txtMobile.hasText {
            Api.shared.updateProfile(self, self.paramDetails(), images: self.paramImage(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.profileUpdatedSuccessfully(), delegate: nil, parentViewController: self) { boool in
                    self.GetProfile()
                }
            }
        } else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func paramDetails() -> [String : String] {
        var dict: [String : String]  = [:]
        dict["user_id"]              = k.userDefault.value(forKey: k.session.userId) as? String
        dict["first_name"]           = self.txtFirstName.text
        dict["last_name"]            = self.txtLastName.text
        dict["mobile"]               = self.txtMobile.text
        dict["email"]                = self.txtEmail.text
        dict["mobile_with_code"]     = self.phoneKey
        dict["lat"]                  = kAppDelegate.CURRENT_LAT
        dict["lon"]                  = kAppDelegate.CURRENT_LON
        print(dict)
        return dict
    }
    
    func paramImage() -> [String : UIImage] {
        var imageDict: [String : UIImage] = [:]
        imageDict["image"]                = self.image
        return imageDict
    }
}

extension EditProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension EditProfileVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
