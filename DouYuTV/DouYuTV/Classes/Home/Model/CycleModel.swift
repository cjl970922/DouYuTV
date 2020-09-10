//
//  CycleModel.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/2.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    @objc var title : String = ""
    
    @objc var pic_url : String = ""

    @objc var room : [String : NSObject]?{
        didSet{
            guard  let room = room  else { return }
            anchor = AnchorModel(dict: room)
            
        }
    }
    
    @objc var anchor : AnchorModel?
    
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
