//
//  GallaryCell.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit
import DropDown

class GallaryCell: UICollectionViewCell {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    let selected_Language = k.userDefault.value(forKey: k.session.language) as? String
    
    var obj: Gallary_Provider_images! {
        didSet {
            if Router.BASE_IMAGE_URL != obj.image ?? "" {
                Utility.setImageWithSDWebImage(obj.image ?? "", self.img)
            } else {
                self.img.image = R.image.placeholder_2()
            }
        }
    }
    
    var selectedName = ""
    var dropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDropDown()
    }

    func configureDropDown()
    {
        dropDown.anchorView = self.btnEdit
        if selected_Language == "english" {
            dropDown.dataSource = ["Delete"]
        } else {
            dropDown.dataSource = ["Supprimer"]
        }
        dropDown.backgroundColor = .white
        dropDown.bottomOffset = CGPoint(x: -100, y: 20)
    }
    
    @IBAction func btnEdit(_ sender: UIButton)
    {
        dropDown.show()
    }
}
