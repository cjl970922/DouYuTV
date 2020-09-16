//
//  BaseViewModel.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/10.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class BaseViewModel {

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}
extension BaseViewModel{
    
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLStirng: URLString, paramer: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.判断是否分组数据
            if isGroupData {
                // 2.1.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else  {
                // 2.1.创建组
                let group = AnchorGroup()
                
                // 2.2.遍历dataArray的所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                
                // 2.3.将group,添加到anchorGroups
                self.anchorGroups.append(group)
            }
            finishedCallback()
        }
    }
}
