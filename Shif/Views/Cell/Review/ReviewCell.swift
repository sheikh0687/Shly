//
//  ReviewCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {

    @IBOutlet weak var cosmosVw: CosmosView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblRatedBy: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    var obj: Res_ProviderDetail! {
        didSet {
            self.cosmosVw.rating = Double(obj.rating ?? "") ?? 0.0
            self.lblRating.text = obj.feedback ?? ""
            self.lblRatedBy.text = "By \(obj.form_details?.first_name ?? "") \(obj.form_details?.last_name ?? "")"
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
