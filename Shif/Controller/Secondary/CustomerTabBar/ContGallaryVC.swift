//
//  ContGallaryVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 09/10/23.
//

import UIKit

class ContGallaryVC: UIViewController {

    @IBOutlet weak var gallaryCollection: UICollectionView!
    
    var arrGallary: [Gallary_Provider_images] = []
    var providerId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gallaryCollection.register(UINib(nibName: "GallaryCell", bundle: nil),forCellWithReuseIdentifier: "GallaryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetGallary()
    }
    
    func GetGallary()
    {
        Api.shared.getProviderDetail(self, paramDetails()) { responseData in
            let obj = responseData
            if obj.provider_images?.count ?? 0 > 0 {
                self.arrGallary = obj.provider_images ?? []
            } else {
                self.arrGallary = []
            }
            self.gallaryCollection.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_id"]            = self.providerId as AnyObject
        print(dict)
        return dict
    }
}

extension ContGallaryVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrGallary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCell", for: indexPath) as! GallaryCell
        cell.btnEdit.isHidden = true
        cell.obj = self.arrGallary[indexPath.row]
        return cell
    }
}

extension ContGallaryVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/2, height: collectionWidth/2)
    }
}
