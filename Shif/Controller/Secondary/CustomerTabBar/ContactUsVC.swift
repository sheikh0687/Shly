//
//  ContactUsVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit

class ContactUsVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtMessage.addHint("Message")
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.contact(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btnSend(_ sender: UIButton) {
        if txtName.hasText && txtMessage.hasText && txtEmail.hasText {
            contact()
        }else{
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheRequiredDetails())
        }
    }
    
    func contact()
    {
        Api.shared.contactUs(self, self.paramDetails()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.weWillContactYouSoon(), delegate: nil, parentViewController: self) { boool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["name"]                   = self.txtName.text as AnyObject
        dict["contact_number"]         = k.emptyString as AnyObject
        dict["email"]                  = self.txtEmail.text as AnyObject
        dict["feedback"]               = self.txtMessage.text as AnyObject
        print(dict)
        return dict
    }
}
