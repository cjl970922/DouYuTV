//
//  MainViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/20.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //调用封装的函数
//        NetworkTools.requestData(type: .GET, URLStirng: "http://httpbin.org/get", paramer: nil) { (reslut) in
//            //打印结果
//            print("结果是:\(reslut)")
//        }
        // Do any additional setup after loading the view.
        
        //不用 editor 中的 refactor to storyboard 的话
//        addChildVc(storyName: "Home")
//        addChildVc(storyName: "Live")
//        addChildVc(storyName: "Follow")
//        addChildVc(storyName: "Pofile")
    }
    
//    private func addChildVc(storyName : String) {
//        //1.通过Storyboard获取控制器
//        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
//
//        //2.将childVc 作为子控制器
//        addChild(childVc)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
