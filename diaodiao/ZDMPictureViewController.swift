//
//  ZDMPictureViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class ZDMPictureViewController: ZDMBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.requestData { 
            self.collectionView.reloadData()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //通过点击的cell获取当前的位置
        let indexPath = self.collectionView.indexPathForCell(sender as! UICollectionViewCell)
        
        if let index = indexPath {
            let model = self.items?[self.feed_list![index.row]]
            
            let dst = segue.destinationViewController as! DetailViewController
            
            dst.buyLink = model?.buylink
        }
    }
}

//MARK: - extension
typealias ZDMWaterfallLayoutDelegate = ZDMPictureViewController
extension ZDMWaterfallLayoutDelegate: CHTCollectionViewDelegateWaterfallLayout {
    //MARK: - CHTCollectionViewDelegateWaterfallLayout
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSizeMake(100, 150)
    }
    
    
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
}

typealias ZDMPictureCollectionDataSource = ZDMPictureViewController
extension ZDMPictureCollectionDataSource: UICollectionViewDataSource {
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard self.items != nil else{
            
            return 0
        }
        
        return self.items!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let c = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ZDMPictureCell
        
        let model = super.items?[super.feed_list![indexPath.row]]!
        
        
        c.configureCell(model!)
        
        return c
    }
    
    
}






