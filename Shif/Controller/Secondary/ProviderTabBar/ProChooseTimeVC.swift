//
//  ProChooseTimeVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 30/12/23.
//

import UIKit

class ProChooseTimeVC: UIViewController {

    @IBOutlet weak var collectionViewOt: UICollectionView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    var arrTimeSlot =
    [
        "01:00","02:00","03:00","04:00",
        "05:00","06:00","07:00","08:00",
        "09:00","10:00","11:00","12:00",
        "13:00","14:00","15:00","16:00",
        "17:00","18:00","19:00","20:00",
        "21:00","22:00","23:00","00:00"
    ]
    
    var cloTimeSlot:((_ time: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewOt.register(UINib(nibName: "ProChooseTimeCell", bundle: nil),forCellWithReuseIdentifier: "ProChooseTimeCell")
    }
}

extension ProChooseTimeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrTimeSlot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProChooseTimeCell", for: indexPath) as! ProChooseTimeCell
        cell.lblTime.text = self.arrTimeSlot[indexPath.row]
        return cell
    }
}

extension ProChooseTimeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.cloTimeSlot?(self.arrTimeSlot[indexPath.row])
        }
    }
}

extension ProChooseTimeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewOt.frame.width / 4, height: 30)
    }
}
