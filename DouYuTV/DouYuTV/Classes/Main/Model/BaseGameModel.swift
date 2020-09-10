//
//  BaseGameModel.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/9.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    @objc var tag_name : String = ""
    @objc var icon_url : String = ""
    
    
    //MARK: - 构造函数
    override init() {
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
