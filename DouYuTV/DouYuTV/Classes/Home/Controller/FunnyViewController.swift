//
//  FunnyViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/14.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class FunnyViewController: BaseAnchorViewController {
    // MARK: 懒加载ViewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
}


extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}


extension FunnyViewController {
    override func loadData() {
        // 1.给父类中的ViewModel进行赋值
        baseVM = funnyVM
        
        // 2.请求数据
        funnyVM.loadFunnyData {
            // 2.1.刷新表格
            self.collectionView.reloadData()
            
            self.loadDataFinished()

        }
    }
}
