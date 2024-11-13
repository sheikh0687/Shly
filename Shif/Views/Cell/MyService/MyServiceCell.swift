//
//  MyServiceCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import DropDown

class MyServiceCell: UITableViewCell {

    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var cloEdit:(() -> Void)?
    var selectedName = ""
    
    var dropDown = DropDown()
    var arrData =
    [
      "Update",
      "Delete"
    ]
    
    var obj: Res_ServiceList! {
        didSet {
            self.lblTitle.text = obj.service_name ?? ""
            self.lblDescription.text = obj.description ?? ""
            self.lblPrice.text = "\(k.currency) \(obj.service_rate ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configureDropDown()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    func configureDropDown()
    {
        dropDown.anchorView = self.btnDrop
        if let language = k.userDefault.value(forKey: k.session.language) as? String{
            if language == "english" {
                dropDown.dataSource = ["Update","Delete"]
            } else {
                dropDown.dataSource = ["Mise à jour","Supprimer"]
            }
        }
        dropDown.backgroundColor = .white
        dropDown.bottomOffset = CGPoint(x: -100, y: 20)
    }
}
