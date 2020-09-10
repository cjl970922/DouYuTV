//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/31.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    @objc var room_list : [[String : Any]]?{
        didSet{ //属性监听器
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
            
        }
    }
    
    @objc var icon_name : String = "home_header_normal"
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
}
