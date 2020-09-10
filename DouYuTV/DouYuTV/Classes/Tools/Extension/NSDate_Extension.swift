//
//  NSDate_Extension.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/31.
//  Copyright © 2020 JLong. All rights reserved.
//

import Foundation

extension NSDate{
    //class改 static
    
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}

