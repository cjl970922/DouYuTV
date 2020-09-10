//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by JLong on 2020/8/27.
//  Copyright © 2020 JLong. All rights reserved.
//

import UIKit

private let kCycleViewH : CGFloat = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    }
// MARK:- 设置UI界面内容
extension RecommendViewController{
    override func setupUI(){
        //1.将UICollectionView添加到控制器的view中
        super.setupUI()
        //2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension RecommendViewController{
    override func loadData(){
        //懒加载就请求了数据 赋值给父类里的baseVM 父类拿到后去渲染
        baseVM = recommendVM
        
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups 
        }
        
        recommendVM.requsetCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout{
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }
        else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
                return CGSize(width: kNormalItemW, height: kPerttyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}

