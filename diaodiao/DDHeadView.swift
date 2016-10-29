
//
//  HeadView.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit


class DDHeadView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    typealias itemClickBlock = (_:ItemInfo)->Void
    typealias toolClickBlock = (_:Tool)->Void
    
    @IBOutlet weak var contentView_ScrollView: UIView!
    @IBOutlet weak var contentView_Width_Constraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var page: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var itemClick:itemClickBlock?
    var toolClick:toolClickBlock?
    
    
    var collectionDataSource = [Tool]()
    var scrollViewDataSource = [ItemInfo]()
    
    var timer:NSTimer! //定时滚动
    
    
    func setHeadViewCollectionDataSource(array:Array<Tool>) -> Void {
        
        self.scrollView.scrollsToTop = false
        self.collectionView.scrollsToTop = false
        
        self.collectionDataSource.appendContentsOf(array)
        
        self.collectionView.reloadData()
    }
    
    func setHeadViewScrollViewBannerDataSource(array:Array<ItemInfo>) -> Void {
        self.scrollViewDataSource.appendContentsOf(array)
        
        for (index,item) in self.scrollViewDataSource.enumerate(){
            
            let imageView = UIImageView(frame: CGRectMake(CGFloat(index) * CGRectGetWidth(contentView_ScrollView.frame), 0, CGRectGetWidth(contentView_ScrollView.frame), CGRectGetHeight(contentView_ScrollView.frame)))
            
            
                imageView.sd_setImageWithURL(NSURL(string: item.banner), completed: { (_, _, _, _) in
                imageView.contentScaleFactor = UIScreen.mainScreen().scale
                    
                imageView.userInteractionEnabled = true
            })
            
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
            
            imageView.tag = index
            imageView.addGestureRecognizer(tap)
            
            
            self.contentView_ScrollView.addSubview(imageView)
                
        }
        
        self.contentView_Width_Constraint.constant = CGFloat(self.scrollViewDataSource.count - 1) * CGRectGetWidth(contentView_ScrollView.frame)
        
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(pageChange), userInfo: nil, repeats: true)
        
        //runloop 保证滚动tableview的时候不会停止定时器
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(self.timer, forMode: NSRunLoopCommonModes)
    }
    
    

    
    
    func pageChange() -> Void {
        
        var x = self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame)
        
        if x > self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame) {
            
            x = 0
        }
        
        let offset = CGPointMake(x, 0)
        
        
        self.scrollView.setContentOffset(offset, animated: true)
        
        let current = Int(x / CGRectGetWidth(self.scrollView.frame))
        
        self.page.currentPage = current
        
        
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            
            let x = scrollView.contentOffset.x
            
            
            let current = Int(x / CGRectGetWidth(scrollView.frame))
            
            self.page.currentPage = current
            
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DDToolCollectionViewCell
        
        cell.configureCell(self.collectionDataSource[indexPath.row])
        
        return cell
    }
    
    
    //处理点击的界面事件
    //MARK: - UICollectionCell的点击
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //以闭包的形式传递出去
        
        if let callback = self.toolClick {
            let toolItem = self.collectionDataSource[indexPath.row]
            callback(toolItem)
        }
    }
    
    func imageViewClick(sender:UITapGestureRecognizer) {
        
       
        if let callback = self.itemClick {
            
            let index = sender.view!.tag
            let model = self.scrollViewDataSource[index]
            
            callback(model)
        }
        
        
    }
    
    override func awakeFromNib() {
        //        self.contentView_ScrollView.backgroundColor = UIColor.greenColor()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.scrollView.delegate = self
    }
    

}



