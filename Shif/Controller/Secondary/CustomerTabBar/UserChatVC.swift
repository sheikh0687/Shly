//
//  UserChatVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class UserChatVC: UIViewController {

    @IBOutlet var tblVwOt: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var isFromNotification = false
    var userName = ""
    
    var arrChat: [Res_Conversation] = []
    var arrFiltered: [Res_Conversation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "ChatsCell", bundle: nil), forCellReuseIdentifier: "ChatsCell")
        
        self.arrFiltered = self.arrChat
        searchBar.delegate = self
        self.searchBar.showsScopeBar = true
        self.searchBar.returnKeyType = .done
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
        self.setNavigationBarItem(LeftTitle: R.string.localizable.message(), LeftImage: "", CenterTitle: userName, CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        GetChatList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func GetChatList()
    {
        Api.shared.getConversation(self, self.paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrChat = responseData
                self.arrFiltered = responseData
            } else {
                self.arrChat = []
                self.arrFiltered = []
            }
            self.tblVwOt.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["receiver_id"]            = k.userDefault.value(forKey: k.session.userId) as AnyObject
        print(dict)
        return dict
    }
}

extension UserChatVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsCell", for: indexPath) as! ChatsCell
        cell.obj = self.arrChat[indexPath.row]
        return cell
    }
}

extension UserChatVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        let obj = self.arrChat[indexPath.row]
        vc.requestId = obj.request_id ?? ""
        print(vc.requestId)
        vc.receiverId = obj.receiver_id ?? ""
        print(vc.receiverId)
        vc.userName = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserChatVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arrChat = self.arrFiltered
        
        if searchText != "" {
            let filterArray = self.arrChat.filter({ $0.first_name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil})
            self.arrChat = filterArray
        }
        self.tblVwOt.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}