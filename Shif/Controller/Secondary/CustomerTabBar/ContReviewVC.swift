//
//  ContReviewVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class ContReviewVC: UIViewController {

    @IBOutlet weak var tblVwOt: UITableView!
    
    var arrReview: [Res_ProviderDetail] = []
    var providerID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVwOt.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetAllReview()
    }
    
    func GetAllReview()
    {
        Api.shared.getProviderReviews(self, self.paramDetail()) { responseData in
            if responseData.count > 0 {
                self.arrReview = responseData
            } else {
                self.arrReview = []
            }
            self.tblVwOt.reloadData()
        }
    }
    
    func paramDetail() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = self.providerID as AnyObject
        return dict
    }
}

extension ContReviewVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.obj = self.arrReview[indexPath.row]
        return cell
    }
}

