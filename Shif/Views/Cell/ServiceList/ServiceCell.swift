//
//  ServiceCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnServiceOt: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    var cloProvider: (() -> Void)?
    var obj: Res_Category! {
        didSet {
            if let language = k.userDefault.value(forKey: k.session.language) as? String,
               language == "english" {
                self.lblTitle.text = obj.name ?? ""
                self.btnServiceOt.setTitle("See Provider", for: .normal)
            } else {
                self.lblTitle.text = obj.name_fr ?? ""
                self.btnServiceOt.setTitle("voir les prestataires", for: .normal)
            }
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", self.img)
            } else {
                self.img.image = R.image.placeholder()
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
    
    @IBAction func btnSeeProvider(_ sender: UIButton) {
        self.cloProvider?()
    }
}
