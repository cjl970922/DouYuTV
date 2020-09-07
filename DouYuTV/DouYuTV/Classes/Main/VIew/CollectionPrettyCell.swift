//
//  CollectionPrettyCell.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/28.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    
    override var anchor : AnchorModel?{
        didSet{
            // 1.将属性传递给父类
            super.anchor = anchor
        
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
