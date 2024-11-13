//
//  ContServiceCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit

class ContServiceCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var obj: Res_ServiceList!
    {
        didSet
        {
            self.lblTitle.text = obj.service_name ?? ""
            self.lblDescription.text = obj.description ?? ""
            self.lblPrice.text = "\(k.currency) \(obj.service_rate ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
