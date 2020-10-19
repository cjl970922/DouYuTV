//
//  PageContentView.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/25.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat,sourceIndex : Int, targetIndex : Int)
}




private let  ContentCellID = "ContentCellID"

class PageContentView: UIView {
    //MARK: - 定义属性
    private var childVcs : [UIViewController]
    //父识图为pageContentView的属性
    //HomeViewController     是它的父识图 中有pagecontentView
    //会导致循环引用
    private weak var parentViewcontroller : UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    
    //MARK: - 懒加载属性
    private lazy var collectionView : UICollectionView = { [weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView
    }()
    
    //自定义构造函数
        
    init(frame: CGRect, childVcs : [UIViewController], parentViewcontroller : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewcontroller = parentViewcontroller
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension PageContentView{
    private func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewcontroller?.addChild(childVc)
        }
        
        //2.添加UIcollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
       // collectionView.backgroundColor = UIColor.red
        
    }
}

//MARK: - 协议

extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //判断是否是点击事件
        if isForbidScrollDelegate {
            return
        }
        var progress : CGFloat = 0 //滑动的比例
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x//当前scrollview的左上角对于内容左上角的便宜
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { //左滑

            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex =  Int(currentOffsetX / scrollViewW)
            
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //将数据通过代理传到titleView
        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX =  scrollView.contentOffset.x
    }
    
}

//MARK: - 对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex :Int) {
        //记录需要禁止执行代理方法
        isForbidScrollDelegate  = true
        //滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}
