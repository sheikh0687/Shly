//
//  UserHomeVC.swift
//  Shif
//
//  Created by Techimmense Software Solutions on 07/10/23.
//

import UIKit

class UserHomeVC: UIViewController {
    
    @IBOutlet weak var imgCollectionVw: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var stackMainVw: UIStackView!
    @IBOutlet weak var view_Height: NSLayoutConstraint!
    @IBOutlet weak var top_View: UIView!
    
    var arrCategory: [Res_Category] = []
    var arrFiltered: [Res_Category] = []
    
    var isFromNotification = false
    
    var arrOfImg: [Res_Banner] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        k.topMargin = UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0) + 100
        self.imgCollectionVw.register(UINib(nibName: "ImageCell", bundle: nil),forCellWithReuseIdentifier: "ImageCell")
        self.tblView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellReuseIdentifier: "ServiceCell")
        
        self.arrFiltered = self.arrCategory
        searchBar.delegate = self
        self.searchBar.showsScopeBar = true
        self.searchBar.returnKeyType = .done
        
        if Utility.isUserLogin() {
            let standardSpacing: CGFloat = 20.0
            NSLayoutConstraint.activate([
             stackMainVw.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
            bottomLayoutGuide.topAnchor.constraint(equalTo: stackMainVw.bottomAnchor, constant: standardSpacing)
            ])
        } else {
            print("No user is not login!!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.WebGetServiceCategory()
        self.GetBannerImages()
        if Utility.isUserLogin() {
            self.top_View.isHidden = true
            if #available(iOS 15, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                appearance.backgroundColor = hexStringToUIColor(hex: "#FAFAFA")
                self.navigationController?.navigationBar.standardAppearance = appearance
                self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            }
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.navigationBar.isHidden = false
            self.setNavigationBarItem(LeftTitle: R.string.localizable.home(), LeftImage: "", CenterTitle: "", CenterImage: "", RightTitle: "", RightImage: "Notification30", BackgroundColor: "", BackgroundImage: "", TextColor: "#000000", TintColor: "#000000", Menu: "")
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.top_View.isHidden = false
            //            self.stackVw.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if Utility.isUserLogin() {
            self.navigationController?.navigationBar.isHidden = true
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func rightClick() {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnNotification(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let vc = R.storyboard.main().instantiateViewController(withIdentifier: "TypeVC") as! TypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func WebGetServiceCategory()
    {
        Api.shared.getCategory(self) { responseData in
            if responseData.count > 0
            {
                self.arrCategory = responseData
                self.arrFiltered = responseData
            }
            else
            {
                self.arrCategory = []
                self.arrFiltered = []
            }
            self.tblView.reloadData()
        }
    }
    
    func GetBannerImages()
    {
        Api.shared.getBannerImage(self) { responseData in
            if responseData.count > 0 {
                self.arrOfImg = responseData
                self.pageControl.numberOfPages = self.arrOfImg.count
            } else {
                self.arrOfImg = []
            }
            self.imgCollectionVw.reloadData()
        }
    }
}

extension UserHomeVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrOfImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.imageCell, for: indexPath)!
        let obj = self.arrOfImg[indexPath.row]
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        } else {
            cell.img.image = R.image.placeholder()
        }
        
        return cell
    }
}

extension UserHomeVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension UserHomeVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.serviceCell, for: indexPath)!
        cell.obj = self.arrCategory[indexPath.row]
        cell.cloProvider = { () in
            let vc = Kstoryboard.instantiateViewController(withIdentifier: "SubCategoryVC") as! SubCategoryVC
            vc.selectedCatId = self.arrCategory[indexPath.row].id ?? ""
            vc.selectedCatName = self.arrCategory[indexPath.row].name ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
}

extension UserHomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arrCategory = self.arrFiltered
        if searchText != "" {
            let filteredArr = self.arrCategory.filter({ $0.name?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil })
            self.arrCategory = filteredArr
        }
        self.tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}

extension UserHomeVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
