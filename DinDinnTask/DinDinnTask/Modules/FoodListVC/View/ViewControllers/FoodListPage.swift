//
//  FoodListPage.swift
//  DinDinnTask
//
//  Created by Codigo Technologies on 28/03/21.
//

import UIKit

class FoodListPage: UIViewController {
    //Header
    @IBOutlet weak var headerContentView: UIView!
    @IBOutlet weak var headerScrollWidth: NSLayoutConstraint!
    @IBOutlet weak var headerScrollView: UIScrollView!
    @IBOutlet weak var headerBgView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    //List
    @IBOutlet weak var itemListScrollWidth: NSLayoutConstraint!
    @IBOutlet weak var itemListScrollView: UIScrollView!
    
    @IBOutlet weak var itemListContentView: UIView!
    
    
    @IBOutlet weak var headerViewHt: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!

    var headerViewMaxHeight : CGFloat = 0
    var headerViewMinHeight : CGFloat = -UIScreen.main.bounds.width
    var bannerImageArr = [#imageLiteral(resourceName: "banner1"),#imageLiteral(resourceName: "banner2"),#imageLiteral(resourceName: "banner3")]
var selectedSubCategoryIndex = 0
    var subCategoryArr = ["Pizza","Sushi","Drink"]
    var bannerTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerViewHt.constant = headerViewMaxHeight
        self.setupHeaderUI()
        

    }
    func setupHeaderUI(){
        self.collectionViewSetup()
        self.bannerSetup()
        self.itemListTableSetup()
        
    }
    func collectionViewSetup(){
        self.collectionView.layer.cornerRadius = 30
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        
        self.collectionView.register(SubCategoryTitleCollectionViewCell.nib, forCellWithReuseIdentifier: SubCategoryTitleCollectionViewCell.identifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    func bannerSetup(){
        self.pageControl.pageIndicatorTintColor = .gray
        self.pageControl.currentPageIndicatorTintColor = .white

        self.headerScrollWidth.constant = CGFloat(bannerImageArr.count) * self.view.frame.size.width
        for pageIndex in 0..<bannerImageArr.count{
            let bannerImageView = UIImageView.init(frame: CGRect(x: CGFloat(pageIndex) * self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width))
            bannerImageView.contentMode = .scaleAspectFill
            bannerImageView.clipsToBounds = true
             bannerImageView.image = bannerImageArr[pageIndex]
             self.headerContentView.addSubview(bannerImageView)
            
            
            bannerImageView.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint(item: bannerImageView, attribute: .leading, relatedBy: .equal, toItem: self.headerContentView, attribute: .leading, multiplier: 1, constant: CGFloat(pageIndex) * self.view.frame.size.width).isActive = true
            NSLayoutConstraint(item: bannerImageView, attribute: .top, relatedBy: .equal, toItem: self.headerContentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: bannerImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.width).isActive = true
            NSLayoutConstraint(item: bannerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.width).isActive = true
 
        }
        if bannerImageArr.count > 0 {
           if self.bannerTimer == nil {
               self.bannerTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.bannerTimerAction), userInfo: nil, repeats: true)
           }
       }
        
        
    }
    @objc func bannerTimerAction()
    {
             var pageNumber: Int = Int(round(self.headerScrollView.contentOffset.x / self.view.frame.size.width))
            if pageNumber < self.pageControl.numberOfPages-1 as Int{
                pageNumber += 1
            }else{
                pageNumber = 0
            }
            self.pageControl.currentPage = Int(pageNumber)
            let x:Float = Float(pageNumber) * Float(self.view.frame.size.width)
            self.headerScrollView.setContentOffset(CGPoint.init(x: Int(x), y: 0), animated: true)
     }
    func itemListTableSetup(){
         self.itemListScrollWidth.constant = CGFloat(subCategoryArr.count) * self.view.frame.size.width
        for pageIndex in 0..<subCategoryArr.count{
            let itemTableView = UITableView.init()
            itemTableView.register(FoodListTableViewCell.nib, forCellReuseIdentifier: FoodListTableViewCell.identifier)

            itemTableView.tag = pageIndex
            itemTableView.dataSource = self
            itemTableView.delegate = self
            itemTableView.separatorStyle = .none
            itemTableView.bounces = false
            let footerView = UIView()
            footerView.frame.size.height = 50
            itemTableView.tableFooterView = footerView
             self.itemListContentView.addSubview(itemTableView)
            
            
            itemTableView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint(item: itemTableView, attribute: .leading, relatedBy: .equal, toItem: self.itemListContentView, attribute: .leading, multiplier: 1, constant: CGFloat(pageIndex) * self.view.frame.size.width).isActive = true
            NSLayoutConstraint(item: itemTableView, attribute: .top, relatedBy: .equal, toItem: self.itemListContentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: itemTableView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.width).isActive = true
            NSLayoutConstraint(item: itemTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.height).isActive = true
            NSLayoutConstraint(item: itemTableView, attribute: .height, relatedBy: .equal, toItem: self.itemListContentView, attribute: .height, multiplier: 1, constant: 0).isActive = true

            itemTableView.reloadData()
            
            //
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedTableView(_:)))
            panGesture.delegate = self
            panGesture.accessibilityHint = "TableViewDrag"
            itemTableView.addGestureRecognizer(panGesture)
             //
            itemListScrollView.isScrollEnabled = true
            itemListScrollView.delegate = self
        }
        
        
    }
    
    @objc func draggedTableView(_ recognizer: UIPanGestureRecognizer) {
         let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
         let y = self.headerViewHt.constant
        if (y + translation.y >= headerViewMinHeight) && (y + translation.y <= headerViewMaxHeight) {
                self.headerViewHt.constant = y + translation.y
            recognizer.setTranslation(CGPoint.zero, in: self.headerBgView)
 
        }
         if recognizer.state == .ended {
          velocity.y >= 0 ? self.listViewMoveToBotton() : self.listViewMoveToTop()
          }
     }
    func listViewMoveToTop() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.headerViewHt.constant = self.headerViewMinHeight
               self.view.layoutIfNeeded()
        }, completion: {(bool) in
 
        })
    }
    func listViewMoveToBotton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.headerViewHt.constant = self.headerViewMaxHeight
 
            self.view.layoutIfNeeded()

        }, completion: {(bool) in
 
        })
    }

}

extension FoodListPage : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width + 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodListCell = tableView.dequeueReusableCell(withIdentifier: FoodListTableViewCell.identifier, for: indexPath) as! FoodListTableViewCell
        foodListCell.selectionStyle = .none
        
        foodListCell.btnAddToCart.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
         return foodListCell
        
    }
    @objc func didTapAddToCart(_ sender:UIButton){
        sender.backgroundColor = .systemGreen
        sender.setTitle("View Cart", for: .normal)
    }
}

extension FoodListPage: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.accessibilityHint == "TableViewDrag"{
            guard let tblView = gestureRecognizer.view as? UITableView else{return true}
            let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
            let directionY = gesture.velocity(in: view).y
            let directionX = gesture.velocity(in: view).x
             let directionIsX = abs(directionY) < abs(directionX)
            if directionIsX{
                return false
            }
            let y = self.headerViewHt.constant
            if (y == headerViewMinHeight && tblView.contentOffset.y <= 0 && directionY > 0) || (y == headerViewMaxHeight) {
            }else{
                return false
            }
        }
 
        return true
    }
     
 }
extension FoodListPage : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let strName = subCategoryArr[indexPath.row]
        let stringWidth = strName.size(OfFont: UIFont.systemFont(ofSize: 26, weight: .bold)).width + 30
        return CGSize(width: stringWidth , height: 50 )

     }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let subCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryTitleCollectionViewCell.identifier, for: indexPath) as! SubCategoryTitleCollectionViewCell
        subCategoryCell.lblTitleName.text = subCategoryArr[indexPath.row]

        subCategoryCell.lblTitleName.textColor =  indexPath.row == self.selectedSubCategoryIndex ? .black : .gray
        return subCategoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSubCategoryIndex = indexPath.row
        self.collectionView.reloadData()
     
        self.itemListScrollView.setContentOffset(CGPoint(x: self.selectedSubCategoryIndex * Int(self.view.frame.size.width), y: 0), animated: true)
    }
    
}

extension FoodListPage{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       if  scrollView == headerScrollView {
           let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
           self.pageControl.currentPage = Int(pageNumber)
       }else if scrollView == self.itemListScrollView{
            
            self.selectedSubCategoryIndex = Int(self.itemListScrollView.contentOffset.x / self.view.frame.size.width)
            self.collectionView.scrollToItem(at: IndexPath(item: self.selectedSubCategoryIndex, section: 0), at: .centeredHorizontally, animated: true)

             self.collectionView.reloadData()

        }
    }
}
extension String {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
