//
//  CustomNavigationController.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/16.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }

        // 2.获取手势添加到的View
        guard let gesView = systemGes.view else { return }
        
        // 3.获取target/action
        // 3.1.利用运行时机制查看所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */

        let targets = systemGes.value(forKey: "_targets") as? [NSObject]

        guard let targetObjc = targets?.first else { return }

        //取出target 和Action
        guard let target = targetObjc.value(forKey: "target") else { return }

        let action = Selector(("handleNavigationTransition:"))
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        

        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }


}
