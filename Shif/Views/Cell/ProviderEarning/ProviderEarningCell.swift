//
//  ProviderEarningCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit

class ProviderEarningCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblSubServiceName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var obj: Res_ProviderTotalEarning! {
        didSet {
            self.lblName.text = "\(obj.user_details?.first_name ?? "") \(obj.user_details?.last_name ?? "")"
            self.lblDateTime.text = "\(obj.date ?? "") \(obj.time_slot ?? "")"
            self.lblAddress.text = obj.address ?? ""
            self.lblServiceName.text = "Service : \(obj.service_name ?? "")"
//            self.lblSubServiceName.text = "Service : \()"
            self.lblPrice.text = "\(k.currency) \(obj.total_amount ?? "") (Card)"
            
            if Router.BASE_IMAGE_URL != obj.user_details?.image ?? "" {
                Utility.setImageWithSDWebImage(obj.user_details?.image ?? "", self.img)
            } else {
                self.img.image = R.image.placeholder_2()
            }
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
