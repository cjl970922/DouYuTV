//
//  NetworkTools.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/31.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}


class NetworkTools {

    class func requestData(type: MethodType, URLStirng: String, paramer: [String : String]? = nil ,finishCallBack:@escaping (_ result: AnyObject)->()){
        //1.获取类型
      let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //发送网络请求
        AF.request(URLStirng, method: method, parameters: paramer, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            //3.获取结果
            guard let result = response.value else{
                
                print(response.error ?? "faile")
                return
            }
            //4.将结果回调回去
            finishCallBack(result as AnyObject)
        }
    }
    // Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
    // print(response.value!)
}
//        AF.request("https://httpbin.org/post",method: .post).responseJSON { (response) in
  //  print(response.value!)

//}
