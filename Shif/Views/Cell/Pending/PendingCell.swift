//
//  PendingCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 06/03/24.
//

import UIKit

class PendingCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStoreService: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCancelOt: UIButton!
    
    var cloChat:(() -> Void)?
    var cloGiveRating:(() -> Void)?
    var cloCancel:(() -> Void)?
    var cloComplete:(() -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.cloCancel?()
    }
}
