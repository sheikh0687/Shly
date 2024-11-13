//
//  NewServiceCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 26/10/23.
//

import UIKit

class NewServiceCell: UITableViewCell {

    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblServicePrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
