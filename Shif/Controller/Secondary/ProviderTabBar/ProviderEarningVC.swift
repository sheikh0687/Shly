//
//  ProviderEarningVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit

class ProviderEarningVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    @IBOutlet weak var lblWalletBalance: UILabel!
    @IBOutlet weak var lblTodayEarning: UILabel!
    @IBOutlet weak var lblTotalEarning: UILabel!
    
    var arrTotalEarning: [Res_ProviderTotalEarning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "ProviderEarningCell", bundle: nil), forCellReuseIdentifier: "ProviderEarningCell")
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
        self.setNavigationBarItem(LeftTitle: R.string.localizable.earning(), LeftImage: "", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.totalEarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnWithdraw(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "ProviderWalletVC") as! ProviderWalletVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func totalEarning()
    {
        Api.shared.getProviderTotalEarning(self, self.paramDetails()) { responseData in
            let obj = responseData
            self.lblWalletBalance.text = "\(k.currency) \(obj.wallet_balence ?? "")"
            self.lblTotalEarning.text = "\(k.currency) \(obj.total_earning ?? "")"
            self.lblTodayEarning.text = "\(k.currency) \(obj.total_earning_today ?? "")"
            
            if responseData.result?.count ?? 0 > 0 {
                self.arrTotalEarning = obj.result ?? []
            } else {
                self.arrTotalEarning = []
            }
            self.tblVwOt.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_id"]            = k.userDefault.value(forKey: k.session.userId) as AnyObject
        print(dict)
        return dict
    }
}

extension ProviderEarningVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTotalEarning.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProviderEarningCell", for: indexPath) as! ProviderEarningCell
        cell.obj = self.arrTotalEarning[indexPath.row]
        return cell
    }
}

