//
//  FunnyViewModel.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/14.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ())  {
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/1", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
