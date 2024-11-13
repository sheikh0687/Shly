//
//  SignupVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 19/03/24.
//

import UIKit
import CountryPickerView

class SignupVC: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var btnHidePassOt: UIButton!
    @IBOutlet weak var btnHideConPassOt: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblTermCondition: UILabel!
    @IBOutlet weak var txtCountryPicker: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var company_View: UIView!
    @IBOutlet weak var btn_CGV: UIButton!
    @IBOutlet weak var lbl_CGVTerms: UILabel!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String?
    var phoneNumber: String = ""
    
    var addressVal = ""
    var lat = 0.0
    var lon = 0.0
  
    var typee = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCountryView()
        self.btnCheckBox.setImage(R.image.rectangleUncheck(), for: .normal)
        self.btn_CGV.setImage(R.image.rectangleUncheck(), for: .normal)
        if let language = k.userDefault.value(forKey: k.session.language) as? String,
           language == "english" {
            self.lblTermCondition.setColor(for: "CGU", with: hexStringToUIColor(hex: "#08A48C"))
            let tap_Gesture1 = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
            lblTermCondition.isUserInteractionEnabled = true
            lblTermCondition.addGestureRecognizer(tap_Gesture1)
            
            self.lbl_CGVTerms.setColor(for: "CGV", with: hexStringToUIColor(hex: "#08A48C"))
            let tap_Gesture2 = UITapGestureRecognizer(target: self, action: #selector(read_CGV))
            lbl_CGVTerms.isUserInteractionEnabled = true
            lbl_CGVTerms.addGestureRecognizer(tap_Gesture2)
            
            self.txtAddress.text = "Select Location"
        } else {
            self.lblTermCondition.setColor(for: "CGU", with: hexStringToUIColor(hex: "#08A48C"))
            let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
            lblTermCondition.isUserInteractionEnabled = true
            lblTermCondition.addGestureRecognizer(tapGesture1)
            
            self.lbl_CGVTerms.setColor(for: "CGV", with: hexStringToUIColor(hex: "#08A48C"))
            let tap_Gesture2 = UITapGestureRecognizer(target: self, action: #selector(read_CGV))
            lbl_CGVTerms.isUserInteractionEnabled = true
            lbl_CGVTerms.addGestureRecognizer(tap_Gesture2)
            
            self.txtAddress.text = "Sélectionnez l'emplacement"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if typee == "USER" {
            company_View.isHidden = true
        } else {
            company_View.isHidden = false
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.createNewAccount(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 16))
        txtCountryPicker.leftView = cp
        txtCountryPicker.leftViewMode = .always
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
    
    @IBAction func btnTappedAddress(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "AddressPickerVC") as! AddressPickerVC
        vc.locationPickedBlock = { addressCordinate, latVal, lonVal, addressVal in
            self.txtAddress.text = addressVal
            self.addressVal = addressVal
            self.lat = latVal
            self.lon = lonVal
        }
        vc.is_Coming = "Signup"
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnShowPassword(_ sender: UIButton) {
        if btnHidePassOt.image(for: .normal) == R.image.hidePassword() {
            btnHidePassOt.setImage(R.image.showPassword(), for: .normal)
            self.txtPassword.isSecureTextEntry = false
        } else {
            btnHidePassOt.setImage(R.image.hidePassword(), for: .normal)
            self.txtPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnShowConfirmPassword(_ sender: UIButton) {
        if btnHideConPassOt.image(for: .normal) == R.image.hidePassword() {
            btnHideConPassOt.setImage(R.image.showPassword(), for: .normal)
            self.txtConfirmPassword.isSecureTextEntry = false
        } else {
            btnHideConPassOt.setImage(R.image.hidePassword(), for: .normal)
            self.txtConfirmPassword.isSecureTextEntry = true
        }
    }
    
    @objc func labelClicked()
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ConditionAndPolicyVC") as! ConditionAndPolicyVC
        vc.which_Is = "TermAndCondition"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func read_CGV()
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ConditionAndPolicyVC") as! ConditionAndPolicyVC
        vc.which_Is = "CGV"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if btnCheckBox.image(for: .normal) == R.image.rectangleUncheck() {
            self.btnCheckBox.setImage(R.image.rectangleChecked(), for: .normal)
        } else {
            self.btnCheckBox.setImage(R.image.rectangleUncheck(), for: .normal)
        }
    }
    
    @IBAction func btn_CheckCGV(_ sender: UIButton) {
        if btn_CGV.image(for: .normal) == R.image.rectangleUncheck() {
            self.btn_CGV.setImage(R.image.rectangleChecked(), for: .normal)
        } else {
            self.btn_CGV.setImage(R.image.rectangleUncheck(), for: .normal)
        }
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        if isValidInput() {
          WebSignUp()
        }
    }
    
    func isValidInput() -> Bool {
        var isValid: Bool = true
        var errorMessage:String = ""
        if (self.txtFirstName.text?.isEmpty)! {
            isValid = false
            errorMessage = R.string.localizable.requiredFirstName()
        } else if (self.txtLastName.text?.isEmpty)! {
            isValid = false
            errorMessage = R.string.localizable.requiredLastName()
        } else if (self.txtEmail.text?.isEmpty)! {
            isValid = false
            errorMessage = R.string.localizable.emailAddressNotFound()
        } else if (self.txtPassword.text?.isEmpty)! {
            isValid = false
            errorMessage = R.string.localizable.pleaseEnterThePassword()
        } else if (self.txtConfirmPassword.text?.isEmpty)! {
            isValid = false
            errorMessage = R.string.localizable.pleaseConfirmPassword()
        } else if self.txtPassword.text != self.txtConfirmPassword.text {
            isValid = false
            errorMessage = "Please enter the same password"
            txtConfirmPassword.becomeFirstResponder()
        } else if btnCheckBox.image(for: .normal) != R.image.rectangleChecked() {
            isValid = false
            errorMessage = R.string.localizable.pleaseReadTheCGUForProceed()
        } else if btn_CGV.image(for: .normal) != R.image.rectangleChecked() {
            isValid = false
            errorMessage = R.string.localizable.pleaseReadTheCGVForProceed()
        }
        
        if (isValid == false) {
            self.alert(alertmessage: errorMessage)
        }
        return isValid
    }
    
    func WebSignUp()
    {
        Api.shared.signup(self, self.paramDetails()) { responseData in
            if responseData.type == "USER" {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.congratulationYourAccountHasBeenCreatedSuccessfully(), delegate: nil, parentViewController: self) { boool in
                    k.userDefault.set(true, forKey: k.session.status)
                    k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
                    k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
                    k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
                    k.userDefault.set(responseData.type ?? "", forKey: k.session.type)
                    k.userDefault.set(responseData.customer_id, forKey: k.session.customerId)
                    k.userDefault.set(responseData.mobile ?? "", forKey: k.session.userMobile)
                    k.userDefault.set(responseData.mobile_with_code ?? "", forKey: k.session.mobileWithCode)
                    Switcher.checkLoginStatus()
                }
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.yourAccountHasBeenSuccessfullyRegisteredPleaseWaitForTheAdministratorSApprovalBeforeUsingTheApplicationThankYouForYourUnderstanding(), delegate: nil, parentViewController: self) { boool in
                    if responseData.status == "1" {
                        k.userDefault.set(true, forKey: k.session.status)
                        k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
                        k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
                        k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
                        k.userDefault.set(responseData.customer_id, forKey: k.session.customerId)
                        k.userDefault.set(responseData.type ?? "", forKey: k.session.type)
                        k.userDefault.set(responseData.mobile ?? "", forKey: k.session.userMobile)
                        k.userDefault.set(responseData.mobile_with_code ?? "", forKey: k.session.mobileWithCode)
                    } else {
                        let mainVC = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                        let checkVC = UINavigationController(rootViewController: mainVC)
                        kAppDelegate.window?.rootViewController = checkVC
                        kAppDelegate.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject]     = [:]
        dict["mobile"]                     = txtMobile.text as AnyObject
        dict["mobile_with_code"]           = self.phoneKey as AnyObject
        dict["first_name"]                 = txtFirstName.text as AnyObject
        dict["store_name"]                 = txtCompanyName.text as AnyObject
        dict["last_name"]                  = txtLastName.text as AnyObject
        dict["email"]                      = txtEmail.text as AnyObject
        dict["password"]                   = txtPassword.text as AnyObject
        dict["register_id"]                = k.emptyString as AnyObject
        dict["ios_register_id"]            = k.iosRegisterId as AnyObject
        dict["type"]                       = typee as AnyObject
        dict["about_us"]                   = k.emptyString as AnyObject
        dict["address"]                    = txtAddress.text as AnyObject
        dict["lat"]                        = self.lat as AnyObject
        dict["lon"]                        = self.lon as AnyObject
        print(dict)
        return dict
    }
}

extension SignupVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
}

extension SignupVC: CountryPickerViewDataSource {
    
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
