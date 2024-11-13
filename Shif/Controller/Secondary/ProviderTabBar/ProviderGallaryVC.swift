//
//  ProviderGallaryVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import Gallery

class ProviderGallaryVC: UIViewController {
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var arrGalleyImg: [Res_GallaryImage] = []
    var arrImage:[[String : AnyObject]] = []
    
    var providerImgId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoCollection.register(UINib(nibName: "GallaryCell", bundle: nil),forCellWithReuseIdentifier: "GallaryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = hexStringToUIColor(hex: "#545454")
            
            // Set the appearance for this view controller's navigation bar
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.gallary(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.galleryImg()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func galleryImg(executedCode: Bool = true)
    {
        Api.shared.getGallerImages(self) { responseData in
            if responseData.count > 0
            {
                self.arrGalleyImg = responseData
                if executedCode {
                    let obj = responseData
                    if obj.count > 0 {
                        for val in obj {
                            Utility.downloadImageBySDWebImage(val.image ?? "") { (image, error) in
                                if error == nil {
                                    if let img = image {
                                        var dict : [String:AnyObject] = [:]
                                        dict["image"] = img as AnyObject
                                        dict["type"] = "server" as AnyObject
                                        dict["id"] = val.id as AnyObject
                                        self.providerImgId = val.id ?? ""
                                        self.arrImage.append(dict)
                                        DispatchQueue.main.async {
                                            print(self.arrImage)
                                            self.photoCollection.reloadData()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                self.arrGalleyImg = []
            }
            self.photoCollection.reloadData()
        }
    }
    
    func deleteGalleryImg(_ imageId: String)
    {
        Api.shared.deleteGalleryImg(self, paramDeleteImg(imageId)) { responseData in
            self.galleryImg(executedCode: false)
        }
    }
    
    func paramDeleteImg(_ providerImgId: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["provider_image_id"]      = providerImgId as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnUploadImg(_ sender: UIButton) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    func uploadImage()
    {
        Api.shared.addGalleryImg(self, addParam(), images: addImage(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.galleryPhotoAddedSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.dismiss(animated: true)
            }
        }
    }
    
    func addParam() -> [String : String] {
        var dict: [String : String] = [:]
        dict["user_id"]             = k.userDefault.value(forKey: k.session.userId) as? String
        return dict
    }
    
    func addImage() -> [String : Array<Any>]
    {
        var dict: [String : Array<Any>] = [:]
        var paramImage:[UIImage] = []
        if self.arrImage.count > 0 {
            for val in self.arrImage {
                if let type = val["type"] as? String, type == "local" {
                    paramImage.append(val["image"] as! UIImage)
                }
            }
        }
        dict["provider_images[]"] = paramImage
        print(dict)
        return dict
    }
}

extension ProviderGallaryVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryCell", for: indexPath) as! GallaryCell
        if let img = arrImage[indexPath.row]["image"] as? UIImage {
            cell.img.image = img
        }
        cell.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            cell.selectedName = item
            if cell.selectedName == R.string.localizable.delete()
            {
                Utility.showAlertYesNoAction(withTitle: k.appName, message: R.string.localizable.areYouSureToDeleteThisImage(), delegate: nil, parentViewController: self) { bool in
                    if bool {
                        let obj = self.arrImage[indexPath.row]
                        if let imgId = obj["id"] as? String {
                            self.deleteGalleryImg(imgId)
                            self.arrImage.remove(at: indexPath.row)
                        }
                    } else {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
        return cell
    }
}

extension ProviderGallaryVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/2, height: collectionWidth/2)
    }
}

extension ProviderGallaryVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrImage.append(dict)
            }
            self?.uploadImage()
            self!.photoCollection.reloadData()
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print(video)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print([Image].self)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        self.dismiss(animated: true, completion: nil)
    }
}

