//
//  ChatVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

class ChatVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    @IBOutlet weak var txtView: UITextView!
    
    var arrMsgs:[Res_Chats] = []
    var requestId = ""
    var receiverId = ""
    var userName = ""
    var refreshControl = UIRefreshControl()
    
    var isFromNotification = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.addHint(R.string.localizable.write())
        self.tblVwOt.register(UINib(nibName: "RightCell", bundle: nil), forCellReuseIdentifier: "RightCell")
        self.tblVwOt.register(UINib(nibName: "LeftCell", bundle: nil), forCellReuseIdentifier: "LeftCell")
        
        if #available(iOS 10.0, *) {
            self.tblVwOt.refreshControl = refreshControl
        } else {
            self.tblVwOt.addSubview(refreshControl)
        }
        DispatchQueue.main.async {
            self.refreshControl.addTarget(self, action: #selector(self.getChat), for: .valueChanged)
        }
        self.getChat()
        NotificationCenter.default.addObserver(self, selector: #selector(ShowRequest), name: Notification.Name("NewMessage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: userName, CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func leftClick() {
        if isFromNotification {
            Switcher.checkLoginStatus()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func ShowRequest (notification:NSNotification) {
        if let Dic = notification.object as? NSDictionary {
            print(Dic)
            self.getChat()
        }
    }
    
    @objc func getChat() {
        Api.shared.user_Chat(self, self.paramGetChat()) { (response) in
            if response.count > 0 {
                self.arrMsgs = response
            } else {
                self.arrMsgs = []
            }
            self.tblVwOt.reloadData {
                self.refreshControl.endRefreshing()
                self.scrollToBottom()
            }
        }
    }
    
    func paramGetChat() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["receiver_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["sender_id"] = receiverId as AnyObject
        dict["request_id"] = requestId as AnyObject
        print(dict)
        return dict
    }

    func scrollToBottom()
    {
        DispatchQueue.main.async
        {
            if self.arrMsgs.count > 0
            {
                let indexPath = IndexPath(row: self.arrMsgs.count-1, section: 0)
                self.tblVwOt.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
//    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //            bottomConst.constant = (keyboardSize.height) * -1.0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            //            bottomConst.constant = 0.0
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func btnSend(_ sender: UIButton) {
        if txtView.text == R.string.localizable.write() || txtView.text.count == 0 {
            self.alert(alertmessage: R.string.localizable.pleaseEnterMessage())
        } else {
            self.sendChat()
        }
    }
    
    func sendChat()
    {
        print(self.paramSendChat())
        Api.shared.addChat(self, self.paramSendChat(), images: [:], videos: [:]) { (response) in
            self.txtView.text = ""
            self.view.endEditing(true)
            self.getChat()
        }
    }
    
    func paramSendChat() -> [String:String] {
        var dict : [String:String] = [:]
        dict["receiver_id"] = self.receiverId
        dict["sender_id"] =  k.userDefault.value(forKey: k.session.userId) as? String
        dict["request_id"] = self.requestId
        dict["type"] = "NORMAL"
        dict["chat_message"] = self.txtView.text!
        dict["timezone"] = localTimeZoneIdentifier
        dict["date_time"] = Utility.getCurrentTime()
        print(dict)   
        return dict
    }
}

extension ChatVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrMsgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.arrMsgs[indexPath.row]
        
        if let checkId = k.userDefault.value(forKey: k.session.userId) as? String, checkId == obj.sender_id
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightCell", for: indexPath) as! RightCell
            cell.textMessage.text = obj.chat_message ?? ""
            cell.lblDateAndTime.text = obj.date_time ?? ""
            
            if obj.receiver_detail?.receiver_image != Router.BASE_IMAGE_URL {
                Utility.setImageWithSDWebImage(obj.receiver_detail?.receiver_image ?? "", cell.profileIme)
            } else {
                cell.profileIme.image = R.image.profile_ic()
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell", for: indexPath) as! LeftCell
            cell.textMessage.text = obj.chat_message ?? ""
            cell.lblDateAndTime.text = obj.date_time ?? ""
            
            if Router.BASE_IMAGE_URL != obj.receiver_detail?.receiver_image {
                Utility.setImageWithSDWebImage(obj.receiver_detail?.receiver_image ?? "", cell.profileIme)
            } else {
                cell.profileIme.image = R.image.profile_ic()
            }
            
            return cell
        }
    }
}

extension ChatVC: UITextViewDelegate
{
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView == txtView
        {
            if txtView.textColor == UIColor.white && txtView.text.count != 0
            {
                txtView.text = ""
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView == txtView
        {
            if txtView.text.count == 0
            {
                txtView.text = "Send Message"
            }
        }
    }
}
