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
    
    func loadAnchorData(URLString : String, parameters : [String : String]? = nil, finishedCallback : @escaping () -> ()){
        NetworkTools.requestData(type: .GET, URLStirng: URLString, paramer: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            finishedCallback()
        }
    }
}
