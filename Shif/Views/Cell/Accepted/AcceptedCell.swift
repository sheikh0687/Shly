//
//  AcceptedCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class AcceptedCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStoreService: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnChatOt: UIButton!
    @IBOutlet weak var btnCancelOt: UIButton!
    @IBOutlet weak var lbl_ProviderStatus: UILabel!
    @IBOutlet weak var view_Constraint: UIView!
    @IBOutlet weak var btn_Temp: UIButton!
    
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
    
    @IBAction func btnChat(_ sender: UIButton) {
        cloChat?()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.cloCancel?()
    }
}
