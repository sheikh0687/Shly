//
//  ProviderAcceptedCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit

class ProviderAcceptedCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblServiceFor: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btn_CompleteOt: UIButton!
    @IBOutlet weak var lbl_RequestStatus: UILabel!
    
    var cloChat:(() -> Void)?
    var cloComplete:(() -> Void)?
    var cloCancel:(() -> Void)?
    
    var obj: Res_ProoviderBookingStatus! {
        didSet {
            self.lblName.text = "\(obj.user_details?.first_name ?? "") \(obj.user_details?.last_name ?? "")"
            self.lblDateTime.text = "\(obj.date ?? "") \(obj.time_slot ?? "")"
            self.lblAddress.text = obj.address ?? ""
            self.lblServiceName.text = "Service : \(obj.service_name ?? "")"
//            self.lblServiceFor.text = "Service For : \(obj.service_name ?? "")"
            self.lblPrice.text = "\(k.currency) \(obj.total_amount ?? "")"
            
            if Router.BASE_IMAGE_URL != obj.user_details?.image {
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
    
    @IBAction func btnChat(_ sender: UIButton) {
        self.cloChat?()
    }
    
    @IBAction func btnComplete(_ sender: UIButton) {
        self.cloComplete?()
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        self.cloCancel?()
    }
}
