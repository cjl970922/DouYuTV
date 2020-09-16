//
//  AmuseViewModel.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/10.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{

}

extension AmuseViewModel {

    func loadAmuseData(finishedCallback : @escaping () -> ()){
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }

}
