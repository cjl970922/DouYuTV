//
//  CollectionNormalCell.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/27.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel?{
        didSet{
            // 1.将属性传递给父类
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
