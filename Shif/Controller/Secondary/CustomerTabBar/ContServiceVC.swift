//
//  ContServiceVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class ContServiceVC: UIViewController {
    
    @IBOutlet weak var tblVwOt: UITableView!
    @IBOutlet weak var tblVwHeight: NSLayoutConstraint!
    
    var arrProviderSerive: [Res_ServiceList] = []
    var providerId = ""
    var scrollView: UIScrollView!
    
    var selectedId: [Int] = []
    var selectedService: [String] = []
    var selectedPrice: [String] = []
    var admin_Fee: [Int] = []
    
    var cloServices: ((_ serviceId: [Int],_ serviceName: [String],_ servicePrice: [String],_ admin_ServiceFee: [Int]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "ContServiceCell", bundle: nil), forCellReuseIdentifier: "ContServiceCell")
        self.scrollView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetProviderService()
    }
    
    func GetProviderService()
    {
        Api.shared.getProviderService(self, self.paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrProviderSerive = responseData
            } else {
                self.arrProviderSerive = []
            }
            self.tblVwOt.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = self.providerId as AnyObject
        print(dict)
        return dict
    }
}

extension ContServiceVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProviderSerive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContServiceCell", for: indexPath) as! ContServiceCell
        cell.obj = self.arrProviderSerive[indexPath.row]
        cell.img.image = selectedId.contains(indexPath.row) ? R.image.rectangleChecked() : R.image.rectangleUncheck()
        print(cell.img.image!)
        return cell
    }
}

extension ContServiceVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedId.contains(indexPath.row) {
            if let index = selectedId.firstIndex(of: indexPath.row) {
                selectedId.remove(at: index)
                selectedService.remove(at: index)
                selectedPrice.remove(at: index)
                print(selectedId)
                print(selectedService)
                print(selectedPrice)
            }
        } else {
            selectedId.append(indexPath.row)
            selectedService.append(arrProviderSerive[indexPath.row].service_name ?? "")
            selectedPrice.append(arrProviderSerive[indexPath.row].service_rate ?? "")
            admin_Fee.append(Int(arrProviderSerive[indexPath.row].admin_service_fee ?? "") ?? 0)
            self.cloServices?(selectedId, selectedService, selectedPrice, admin_Fee)
        }
        tableView.reloadRows(at: [indexPath], with: .none) // Reload the cell to update the image
    }
}
