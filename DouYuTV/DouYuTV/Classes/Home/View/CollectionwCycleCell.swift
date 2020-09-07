//
//  CollectionwCycleCell.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/2.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class CollectionwCycleCell: UICollectionViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var cycleModel : CycleModel? {
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
