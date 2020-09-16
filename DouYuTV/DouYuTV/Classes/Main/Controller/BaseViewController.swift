//
//  BaseViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/9/14.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}


extension BaseViewController {
    @objc func setupUI(){
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished(){
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
