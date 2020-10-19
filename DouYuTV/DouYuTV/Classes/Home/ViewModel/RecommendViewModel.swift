//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/31.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel{

    lazy var cycleModels : [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyDataGroup : AnchorGroup = AnchorGroup()
    
}

// MARK:- 发送网络请求
extension RecommendViewModel{
    func requestData(finishCallback : @escaping () -> ()){
        
        let parameters = ["limit" : "4","offset" : "0", "time" : NSDate.getCurrentTime()]
        
        let dGroup = DispatchGroup()
        
        // 1.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLStirng: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramer: ["time" : NSDate.getCurrentTime()]) { (result) in
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性

            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            // 3.2.获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
            print("请求到推荐部分游戏数据")
        }
        
        // 2.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, URLStirng: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paramer: parameters) { (result) in
           // print(result)
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return}
            // 3.遍历字典,并且转成模型对象
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
            print("请求到颜值部分游戏数据")
        }
    
        // 3.请求2-12部分游戏数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
            print("请求到2-12部分游戏数据")
        }
    
        //所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            print("所有的数据都请求到")
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    // 请求无线轮播的数据
    func requsetCycleData(finishCallback : @escaping () -> ())  {
        NetworkTools.requestData(type: .GET, URLStirng: "http://www.douyutv.com/api/v1/slide/6") { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }

}
