//
//  CompleteCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 06/03/24.
//

import UIKit

class CompleteCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStoreService: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnGiveRatingOt: UIButton!
    @IBOutlet weak var btnCompleteOt: UIButton!
    @IBOutlet weak var btn_TempOt: UIButton!
    
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
    
    @IBAction func btnGiveRate(_ sender: UIButton) {
        self.cloGiveRating?()
    }
    
    @IBAction func btnComplete(_ sender: UIButton) {
        self.cloComplete?()
    }
}
