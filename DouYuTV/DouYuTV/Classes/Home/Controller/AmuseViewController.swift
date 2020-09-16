//
//  AmuseViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/10.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM : AmuseViewModel  = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
extension AmuseViewController{
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


extension AmuseViewController{
     override func loadData() {
        //懒加载就请求了数据 赋值给父类里的baseVM 父类拿到后去渲染
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            self.loadDataFinished()
        }
        
    }
}



