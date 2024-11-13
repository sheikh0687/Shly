//
//  NotificationVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    
    var arrOfNotification: [Res_Notification] = []
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.notification(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.GetNotificationList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func GetNotificationList()
    {
        Api.shared.get_NotificationList(self) { responseData in
            if responseData.count > 0 {
                self.arrOfNotification = responseData
            } else {
                self.arrOfNotification = []
            }
            self.tblVwOt.reloadData()
        }
    }
}

extension NotificationVC: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOfNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let obj = self.arrOfNotification[indexPath.row]
        
        if language == "english" {
            cell.lbl_title.text = obj.title ?? ""
            cell.lbl_Message.text = obj.message ?? ""
        } else {
            cell.lbl_title.text = obj.title_fr ?? ""
            cell.lbl_Message.text = obj.message_fr ?? ""
        }
        cell.lbl_DateTime.text = obj.date_time ?? ""
        
        return cell
    }
}
