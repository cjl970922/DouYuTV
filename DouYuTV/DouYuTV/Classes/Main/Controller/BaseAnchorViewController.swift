//
//  BaseAnchorViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/10.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kHeaderViewID = "kHeaderView"
private let kNormalCellID = "kNormalCellID"

 let kPrettyCellID = "kPrettyCellID"
 let kNormalItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
 let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
 let kPerttyItemH : CGFloat = kNormalItemW * 4 / 3


class BaseAnchorViewController: BaseViewController {

    var baseVM : BaseViewModel!
    
     lazy var collectionView : UICollectionView = { [unowned self] in

           
           let layout = UICollectionViewFlowLayout()
           layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
           layout.minimumLineSpacing = 0
           layout.minimumInteritemSpacing = kItemMargin
           layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
           layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
           
        
           let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
           //随着父视图来调节大小
           collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
           collectionView.dataSource = self
           collectionView.delegate = self
           
           collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
           collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
           
           collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
           collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
           
           collectionView.backgroundColor = UIColor.white
           return collectionView
       }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension BaseAnchorViewController {
     override func setupUI() {
        
        contentView = collectionView
        view.addSubview(collectionView)
        super.setupUI()
        
        
        

    }
}

extension BaseAnchorViewController{
    @objc func loadData() {

    }
}

extension BaseAnchorViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        anchor.isVertical == 0 ? pushNormalRoomVc() : presentShowRoomVc()
        
    }
    
    private func presentShowRoomVc(){
        let showRoomVc = RoomShowViewController()
        
        present(showRoomVc, animated: true, completion: nil)
        
    }
    
    private func pushNormalRoomVc(){
        let normalRoomVc = RoomNormalViewController()
        
        navigationController?.pushViewController(normalRoomVc, animated: true)
        
    }
}

