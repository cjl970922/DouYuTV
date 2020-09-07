//
//  CollectionBaseCell.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/1.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!

    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else { return }
            
            var onlineStr :String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000 ))万在线"
            }
            else{
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }
    
}
