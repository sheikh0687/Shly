//
//  ProviderServiceVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 10/10/23.
//

import UIKit
import DropDown
import Gallery

class ProviderServiceVC: UIViewController {

    @IBOutlet var collec_Photo: UICollectionView!
    @IBOutlet weak var btnCatDrop: UIButton!
    @IBOutlet weak var btnSubCatDrop: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    var isComingFrom = ""
    var selectedCatId = ""
    var selectedCatName = ""
    var selectedSubCatId = ""
    var selectedSubCatName = ""
    
    var catDropDown = DropDown()
    var subCatDropDown = DropDown()
    
    var arrCategory: [Res_Category] = []
    var arrSubCategory: [Res_SubCategory] = []
    var arrImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtDescription.addHint(R.string.localizable.enter())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = hexStringToUIColor(hex: "#FAFAFA")
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        self.navigationController?.navigationBar.isHidden = false
        if isComingFrom == "ProviderMyServiceVC"
        {
            self.tabBarController?.tabBar.isHidden = true
            self.setNavigationBarItem(LeftTitle: "", LeftImage: "black_back", CenterTitle: R.string.localizable.addService(), CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        }
        else
        {
            self.tabBarController?.tabBar.isHidden = false
            self.setNavigationBarItem(LeftTitle: R.string.localizable.addService(), LeftImage: "", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        }
        self.category()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func rightClick() {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTapImage(_ sender: UIButton) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
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
            if let lang = k.userDefault.value(forKey: k.session.language) as? String,
               lang == "english" {
                arrCatName.append(val.name ?? "")
            } else {
                arrCatName.append(val.name_fr ?? "")
            }
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
            if let lang = k.userDefault.value(forKey: k.session.language) as? String,
               lang == "english" {
                arrSubCatName.append(val.name ?? "")
            } else {
                arrSubCatName.append(val.name_fr ?? "")
            }
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
    
    @IBAction func btnAdd(_ sender: UIButton) 
    {
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
        
        self.addService()
    }
    
    func addService()
    {
        Api.shared.addServices(self, paramDetails(), images: imageParam(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: R.string.localizable.serviceAddedSuccessfully(), delegate: nil, parentViewController: self) { bool in
                self.dismiss(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : String]
    {
        var dict: [String : String] = [:]
        dict["user_id"]             = k.userDefault.value(forKey: k.session.userId) as? String
        dict["service_name"]        = self.txtTitle.text
        dict["description"]         = self.txtDescription.text
        dict["service_rate"]        = self.txtPrice.text
        dict["working_time"]        = k.emptyString
        dict["cat_id"]              = self.selectedCatId
        dict["cat_name"]            = self.selectedCatName
        dict["sub_cat_id"]          = self.selectedSubCatId
        dict["sub_cat_name"]        = self.selectedSubCatName
        return dict
    }
    
    func imageParam() -> [String : Array<Any>] 
    {
        var imageDict: [String : Array<Any>] = [:]
        imageDict["service_images[]"]        = self.arrImage
        return imageDict
    }
}

extension ProviderServiceVC: UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        cell.btn_Image.setImage(arrImage[indexPath.row], for: .normal)
        cell.btn_Image.tag = indexPath.row
        cell.btn_Image.addTarget(self, action: #selector(click_On_tab(button:)), for: .touchUpInside)
        
        cell.btn_cross.isHidden = false
        cell.btn_cross.tag = indexPath.row
        cell.btn_cross.addTarget(self, action: #selector(click_On_Cross(button:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func click_On_Cross(button:UIButton)  {
        arrImage.remove(at: button.tag)
        self.collec_Photo.reloadData()
    }
    
    @objc func click_On_tab(button:UIButton)  {
    }
}

extension ProviderServiceVC: GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            self!.arrImage = resolvedImages.compactMap({ $0 })
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

extension ProviderServiceVC: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: 100, height: 90)
    }
}

