//
//  ProviderUpdateServiceVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 11/10/23.
//

import UIKit
import DropDown
import Gallery

class ProviderUpdateServiceVC: UIViewController {
    
    @IBOutlet var collec_Photo: UICollectionView!
    @IBOutlet weak var btnCatDrop: UIButton!
    @IBOutlet weak var btnSubCatDrop: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    var requestId = ""
    
    var selectedCatId = ""
    var selectedCatName = ""
    var selectedSubCatId = ""
    var selectedSubCatName = ""
    
    var catDropDown = DropDown()
    var subCatDropDown = DropDown()
    
    var arrCategory: [Res_Category] = []
    var arrSubCategory: [Res_SubCategory] = []
    var arrImage:[[String : AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(requestId)
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
        self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.updateService(), CenterImage: "", RightTitle: "", RightImage: "", BackgroundColor: "#545454", BackgroundImage: "", TextColor: "#ffffff", TintColor: "#ffffff", Menu: "")
        self.category()
        self.getServiceDetails(forServiceID: requestId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnTapImage(_ sender: UIButton) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    func getServiceDetails(forServiceID serviceID: String, excutedCode: Bool = true) {
        Api.shared.getServiceDetails(self, paramGetServiceDt(serviceID)) { responseData in
            let obj = responseData
            self.txtTitle.text = obj.service_name ?? ""
            self.txtPrice.text = obj.service_rate ?? ""
            self.txtDescription.text = obj.description ?? ""
            self.btnCatDrop.setTitle(obj.cat_name ?? "", for: .normal)
            self.btnSubCatDrop.setTitle(obj.sub_cat_name ?? "", for: .normal)
            self.selectedCatId = obj.cat_id ?? ""
            self.selectedSubCatId = obj.sub_cat_id ?? ""
            self.selectedCatName = obj.cat_name ?? ""
            self.selectedSubCatName = obj.sub_cat_name ?? ""
            if excutedCode {
                if let serviceImages = obj.service_images {
                    for val in serviceImages {
                        Utility.downloadImageBySDWebImage(val.image ?? "") { image, error in
                            if error == nil {
                                if let img = image {
                                    var dict: [String : AnyObject] = [:]
                                    dict["image"] = img as AnyObject
                                    dict["type"]  = "server" as AnyObject
                                    dict["id"] = val.id as AnyObject
                                    self.arrImage.append(dict)
                                    DispatchQueue.main.async {
                                        self.collec_Photo.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func paramGetServiceDt(_ requestId: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["service_id"]             = requestId as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnDropDown(_ sender: UIButton) {
        catDropDown.show()
    }
    
    func category() {
        Api.shared.getCategory(self) { responseData in
            if responseData.count > 0 {
                self.arrCategory = responseData
            } else {
                self.arrCategory = []
            }
            self.configureDropDown1()
        }
    }
    
    func configureDropDown1()
    {
        var arrCatId: [String] = []
        var arrCatName: [String] = []
        for val in arrCategory {
            arrCatId.append(val.id ?? "")
            arrCatName.append(val.name ?? "")
        }
        
        catDropDown.anchorView = btnCatDrop
        catDropDown.dataSource = arrCatName
        catDropDown.bottomOffset = CGPoint(x: 0, y: 45)
        catDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedCatId = arrCatId[index]
            self.selectedCatName = item
            self.subCategory()
            self.btnCatDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnSubCatDrop(_ sender: UIButton) {
        subCatDropDown.show()
    }
    
    func subCategory() {
        Api.shared.getSubCategory(self, paramDetails()) { responseData in
            if responseData.count > 0 {
                self.arrSubCategory = responseData
            } else {
                self.arrSubCategory = []
            }
            self.configureDropDown2()
        }
    }
    
    func paramDetails() -> [String : AnyObject] {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["category_id"]            = self.selectedCatId as AnyObject
        print(dict)
        return dict
    }
    
    func configureDropDown2() {
        var arrSubCatId: [String] = []
        var arrSubCatName: [String] = []
        for val in self.arrSubCategory {
            arrSubCatId.append(val.id ?? "")
            arrSubCatName.append(val.name ?? "")
        }
        
        subCatDropDown.anchorView = btnSubCatDrop
        subCatDropDown.dataSource = arrSubCatName
        subCatDropDown.bottomOffset = CGPoint(x: 0, y: 45)
        subCatDropDown.selectionAction = {[unowned self] (index: Int, item: String) in
            self.selectedSubCatId = arrSubCatId[index]
            self.selectedSubCatName = item
            self.btnSubCatDrop.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        guard let title = self.txtTitle.text, !title.isEmpty else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheTitle())
            return
        }
        
        guard let price = self.txtPrice.text, !price.isEmpty else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterThePrice())
            return
        }
        
        guard let description = self.txtDescription.text, !description.isEmpty else {
            self.alert(alertmessage: R.string.localizable.pleaseEnterTheDescription())
            return
        }
        
        guard !self.selectedCatId.isEmpty else {
            self.alert(alertmessage: R.string.localizable.pleaseSelectTheCategory())
            return
        }
        
        guard !self.selectedSubCatId.isEmpty else {
            self.alert(alertmessage: R.string.localizable.pleaseSelectTheSubCategory())
            return
        }
        self.updateService()
    }
    
    func updateService()
    {
        Api.shared.updateService(self, paramUpdateService(), images: paramUpdateImg(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.serviceUpdatedSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.getServiceDetails(forServiceID: self.requestId, excutedCode: false)
            }
        }
    }
    
    func paramUpdateService() -> [String : String]
    {
        var dict: [String : String] = [:]
        dict["user_id"]             = k.userDefault.value(forKey: k.session.userId) as? String
        dict["service_id"]          = self.requestId
        dict["service_name"]        = self.txtTitle.text
        dict["description"]         = self.txtDescription.text
        dict["service_rate"]        = self.txtPrice.text
        dict["working_time"]        = k.emptyString
        dict["cat_id"]              = self.selectedCatId
        dict["cat_name"]            = self.selectedCatName
        dict["sub_cat_id"]          = self.selectedSubCatId
        dict["sub_cat_name"]        = self.selectedSubCatName
        print(dict)
        return dict
    }
    
    func paramUpdateImg() -> [String : Array<Any>] 
    {
        var dict: [String : Array<Any>] = [:]
        var paramImage: [UIImage] = []
        if self.arrImage.count > 0 {
            for val in self.arrImage {
                if let type = val["type"] as? String, type == "local" {
                    paramImage.append(val["image"] as! UIImage)
                }
            }
        }
        dict["service_images"] = paramImage
        return dict
    }
}

extension ProviderUpdateServiceVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        if let img = arrImage[indexPath.row]["image"] as? UIImage {
            cell.btn_Image.setImage(img, for: .normal)
        }
        cell.btn_Image.tag = indexPath.row
        cell.btn_Image.addTarget(self, action: #selector(click_On_tab(button:)), for: .touchUpInside)
        
        cell.btn_cross.isHidden = false
        cell.btn_cross.tag = indexPath.row
        cell.btn_cross.addTarget(self, action: #selector(click_On_Cross(button:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func click_On_Cross(button:UIButton)  {
        print(button.tag)
        arrImage.remove(at: button.tag)
        self.collec_Photo.reloadData()
    }
    
    @objc func click_On_tab(button:UIButton)  {
    }
}

extension ProviderUpdateServiceVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrImage.append(dict)
            }
            self!.collec_Photo.reloadData()
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

extension ProviderUpdateServiceVC: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: 100, height: 90)
    }
}

