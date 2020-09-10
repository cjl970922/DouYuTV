//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/20.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

private let KTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //有安全区域的就得➕24。之后再适配吧
    //懒加载属性
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH  , width: kScreenW, height: KTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩",]
        
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
       // titleView.backgroundColor = UIColor.purple
        
        return titleView
    }() //闭包
    
    private lazy var pageContentView : PageContentView = { [weak self] in
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - KTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + KTitleViewH, width: kScreenW, height: contentH)

        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())

            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVcs.append(vc)
        
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewcontroller: self)
        
        contentView.delegate = self
        
        return contentView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK: -设置UI界面
extension HomeViewController{
    private func setupUI(){
        //0.不需要自动调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //   edgesForExtendedLayout =
       // UIScrollView.ContentInsetAdjustmentBehavior
      //  self.additionalSafeAreaInsets = UIEdgeInsetsMake(-``44``, ``0``, ``0``, ``0``);
     //   additionalSafeAreaInsets = UIEdgeInsets.init(top: -44, left: 0, bottom: 0, right: 0)
        //1.设置导航栏
        setupNavigationBar()
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    private func setupNavigationBar(){
        //1.设置左侧的item
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()// 自适应大小
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2.设置右侧的item
        

        let size = CGSize(width: 35, height: 35)
//                let historyBtn = UIButton()
//                historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//                historyBtn.setImage(UIImage(named: "image_my_history_click"), for: .highlighted)
//                historyBtn.sizeToFit()
//                let historyItem = UIBarButtonItem(customView: historyBtn)
        
        //调用创建的类方法
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        //调用创建的构造方法
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
//        searchBtn.setImage(UIImage(named: "btn_search_click"), for: .highlighted)
//        searchBtn.sizeToFit()
//        let searchItem = UIBarButtonItem(customView: searchBtn)
//
//        let qrcodeBtn = UIButton()
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
//        qrcodeBtn.sizeToFit()
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
       }
}


//MARK: - 遵守pageTitleDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 遵守pageContentViewDelegate协议
extension HomeViewController :PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
