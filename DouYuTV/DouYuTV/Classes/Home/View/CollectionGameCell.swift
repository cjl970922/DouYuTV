//
//  CollectionGameCell.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/2.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var baseGame : BaseGameModel? {
        didSet{
            titleLabel.text = baseGame?.tag_name
            let iconURL = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
