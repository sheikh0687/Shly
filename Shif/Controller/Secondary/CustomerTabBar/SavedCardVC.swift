//
//  SavedCardVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 18/01/24.
//

import UIKit
import SwiftyJSON

class SavedCardVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!
    
    var arr_Card_Data: [Res_Data] = []
    var cloCardDetail:((_ cardId: String,_ cardBrand : String,_ cardLastFour: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVw.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.savedCards(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        self.tabBarController?.tabBar.isHidden = true
        self.retrieve_All_Card()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func retrieve_All_Card()
    {
        Api.shared.retrieve_Card(self, param_Retrieve_Card()) { responseData in
            if let objData = responseData.data {
                if objData.count > 0 {
                    self.arr_Card_Data = objData
                } else {
                    self.arr_Card_Data = []
                }
                self.tblVw.reloadData()
            }
        }
    }
    
    func param_Retrieve_Card() -> [String : AnyObject] {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["customer_id"]            = k.userDefault.value(forKey: k.session.customerId) as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnAddCard(_ sender: UIButton)
    {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func delete_SavedCard(cardId: String)
    {
        Api.shared.delete_SavedCard(self, param_DeleteCard(cardId: cardId)) { responseData in
            self.parseDataSaveCard(apiResponse: responseData)
        }
    }
    
    func parseDataSaveCard(apiResponse : AnyObject) {
        DispatchQueue.main.async {
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == "1") {
                print(swiftyJsonVar["result"]["id"].stringValue)
                Utility.showAlertWithAction(withTitle: k.appName, message: "Card deleted successfully", delegate: nil, parentViewController: self, completionHandler: { (boool) in
                    self.retrieve_All_Card()
                    self.dismiss(animated: true)
                })
            } else {
                Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.somethingWentWrong(), delegate: nil, parentViewController: self, completionHandler: { (boool) in
                })
            }
            self.unBlockUi()
        }
    }
    
    func param_DeleteCard(cardId: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["card_id"]                = cardId as AnyObject
        dict["customer_id"]            = k.userDefault.value(forKey: k.session.customerId) as AnyObject
        print(dict)
        return dict
    }
}

extension SavedCardVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_Card_Data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        let obj = self.arr_Card_Data[indexPath.row]
        cell.lblCardName.text = "\(obj.brand ?? "")  **** **** **** \(obj.last4 ?? "")"
        cell.cloChoose = {() in
            self.cloCardDetail?(obj.id ?? "", obj.brand ?? "", obj.last4 ?? "")
            self.navigationController?.popViewController(animated: true)
        }
        cell.cloDelete = {() in
            self.delete_SavedCard(cardId: obj.id ?? "")
        }
        return cell
    }
}
