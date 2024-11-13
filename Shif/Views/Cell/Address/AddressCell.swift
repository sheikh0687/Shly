//
//  AddressCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    var cloDelete:(() -> Void)?
    var cloChoose:(() -> Void)?
    
    var obj: Res_Address! {
        didSet {
            self.lblAddress.text = obj.address ?? ""
            self.lblTitle.text = obj.addresstype ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDelete(_ sender: UIButton) {
        self.cloDelete?()
    }
    
    @IBAction func btnChoose(_ sender: UIButton) {
        self.cloChoose?()
    }
}
