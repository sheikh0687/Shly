//
//  SearchResultCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var lblProvider: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var cloDetails:(() -> Void)?
    
    var obj: Res_ServiceFilter! {
        didSet {
            self.lblProvider.text = "\(obj.store_name ?? "")(\(obj.type ?? ""))"
            self.lblRating.text = "\(obj.rating ?? "") (\(obj.rating_count ?? 0))"
            self.lblDistance.text = "\(obj.distance ?? "")Km"
            self.lblAddress.text = obj.address ?? ""
            
            if Router.BASE_IMAGE_URL != obj.store_logo {
                Utility.setImageWithSDWebImage(obj.store_logo ?? "", self.img)
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
    }
    
    @IBAction func btnViewDt(_ sender: UIButton) {
        self.cloDetails?()
    }
}
