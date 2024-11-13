//
//  CardCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 18/01/24.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var lblCardName: UILabel!
    
    var cloChoose:(() -> Void)?
    var cloDelete:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnChoose(_ sender: UIButton) {
        self.cloChoose?()
    }
    
    @IBAction func btn_Delete(_ sender: UIButton) {
        self.cloDelete?()
    }
}
