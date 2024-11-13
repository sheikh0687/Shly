//
//  ProviderTimeSlotCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/12/23.
//

import UIKit

class ProviderTimeSlotCell: UITableViewCell {
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var btnStatusOt: UIButton!
    @IBOutlet weak var btnOpenTime: UIButton!
    @IBOutlet weak var btnCloseTime: UIButton!
    
    var cloStatus: ((_ status: String) -> Void)?
    var cloOpenTime: (() -> Void)?
    var cloCloseTime: (() -> Void)?
    
    let language = k.userDefault.value(forKey: k.session.language) as? String
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnStatus(_ sender: UIButton) {
        if sender.backgroundColor == hexStringToUIColor(hex: "#15B67C") {
            sender.backgroundColor = .lightGray
            if language == "english" {
                sender.setTitle("CLOSE", for: .normal)
            } else {
                sender.setTitle("FERME", for: .normal)
            }
            self.cloStatus?("CLOSE")
        } else {
            sender.backgroundColor = hexStringToUIColor(hex: "#15B67C")
            if language == "english" {
                sender.setTitle("OPEN", for: .normal)
            } else {
                sender.setTitle("OUVERT", for: .normal)
            }
            self.cloStatus?("OPEN")
        }
    }
    
    @IBAction func btnOpenTime(_ sender: UIButton) {
        self.cloOpenTime?()
    }
    
    @IBAction func btnCloseTime(_ sender: UIButton) {
        self.cloCloseTime?()
    }
}
