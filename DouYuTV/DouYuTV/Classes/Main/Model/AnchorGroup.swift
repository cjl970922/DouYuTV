//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/31.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    @objc var room_list : [[String : NSObject]]?{
        didSet{ //属性监听器
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
            
        }
    }
    
    @objc var tag_name : String = ""
    
    @objc var icon_name : String = "home_header_normal"
    
    @objc var icon_url : String = ""
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    //MARK: - 构造函数
    override init() {
    }
    
    init(dict : [String : NSObject]){
        
        super.init()
        
        setValuesForKeys(dict)

    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    
}
