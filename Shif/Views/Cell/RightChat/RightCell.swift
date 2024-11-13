//
//  RightCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 02/11/23.
//

import UIKit

class RightCell: UITableViewCell {

    @IBOutlet var lblDateAndTime: UILabel!
    @IBOutlet var textMessage: UILabel!
    @IBOutlet var profileIme: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
