//
//  AmuseViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/10.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit



class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM : AmuseViewModel  = AmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension AmuseViewController{
     override func loadData() {
        //懒加载就请求了数据 赋值给父类里的baseVM 父类拿到后去渲染
        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
        
    }
}



