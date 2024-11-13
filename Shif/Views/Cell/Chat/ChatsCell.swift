//
//  ChatsCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class ChatsCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    var obj: Res_Conversation! {
        didSet {
            self.lblName.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
            self.lblMessage.text = obj.last_message ?? ""
            self.lblDateTime.text = obj.date_time ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", self.img)
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
