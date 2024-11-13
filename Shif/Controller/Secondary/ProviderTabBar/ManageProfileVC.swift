//
//  ManageProfileVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import CountryPickerView

class ManageProfileVC: UIViewController {

    @IBOutlet weak var btnImage: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCountryPicker: UITextField!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
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
        self.providerProfile()
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
    
    @IBAction func btnImageTapped(_ sender: UIButton) {
    }
    
    func providerProfile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.lblName.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
            self.lblAddress.text = obj.address ?? ""
            self.txtMobile.text = obj.mobile ?? ""
            self.txtCountryPicker.text = obj.mobile_with_code ?? ""
            self.txtEmail.text = obj.email ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.downloadImageBySDWebImage(obj.image ?? "") { image, error in
                    if error == nil {
                        self.btnImage.setImage(image, for: .normal)
                    } else {
                        self.btnImage.setImage(R.image.profile_ic(), for: .normal)
                    }
                }
            }else {
                self.btnImage.setImage(R.image.profile_ic(), for: .normal)
            }
        }
    }
    
    @IBAction func btnEditProfile(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderEditProfileVC") as! ProviderEditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnManageProviderPro(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderManageProfileVC") as! ProviderManageProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ManageProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension ManageProfileVC: CountryPickerViewDataSource {
    
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
