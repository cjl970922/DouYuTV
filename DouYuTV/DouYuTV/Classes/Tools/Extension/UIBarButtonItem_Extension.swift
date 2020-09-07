//
//  UIBarButtonItem_Extension.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/20.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //创建类方法
//    class func createItem(imageName : String, highImageName :String, size: CGSize ) ->UIBarButtonItem{
//        
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        
//        
//        return UIBarButtonItem(customView: btn)
//    }
    
    //便利构造函数： 1. convenience 开头 2. 在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName : String, highImageName :String = "", size: CGSize = CGSize.zero){
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        
        if highImageName != ""{
             btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        } else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }
}
