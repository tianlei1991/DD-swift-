//
//  CustomeLayout.swift
//  collectionDecView
//
//  Created by honey on 16/5/10.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

class CustomeLayout: UICollectionViewFlowLayout {
    
    lazy var attributes = [UICollectionViewLayoutAttributes]()
    
    var numberOfColumn:Int = 2//默认为2列
    
    
    override init() {
        super.init()
        //设置默认的段间距
        self.defalutConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.defalutConfig()
    }
    
    func defalutConfig() {
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        //设置默认的行间距
        self.minimumLineSpacing = 5
        //设置默认的列间距
        self.minimumInteritemSpacing = 5
        //设置默认的item大小
        self.itemSize = CGSizeMake(100, 200)
        self.headerReferenceSize = CGSizeMake(0, 90)
    }
    
    override func prepareLayout() {
        
        super.prepareLayout()
        
        self.registerClass(DiscoveryCellBackground.self, forDecorationViewOfKind: "DD")
        
        let contentWidth = self.collectionViewContentSize().width
        
        //根据当前的列数重新计算每个item的大小
        // contentWidth - (左侧大小 + 右侧大小 + 空隙*(item个数-1)) == 实际要布局的contentView的大小
        let newItemWidth = (contentWidth - (self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing * CGFloat(self.numberOfColumn - 1))) / CGFloat(self.numberOfColumn)
        //高度沿用原来的高度
        let newItemheight = self.itemSize.height
        
        self.itemSize = CGSizeMake(newItemWidth, newItemheight)
    }
    
    
    //MARK: - 计算总的contentSize
    override func collectionViewContentSize() -> CGSize {
        
        let width = self.collectionView!.frame.size.width
        
        var height = CGFloat(0)
        
        for i in 0 ..< self.collectionView!.numberOfSections() {
            //算出每一段的高度
            //(每一个item的高度  + 行间距) * 总行数 + 段间距 - 多余的行间距
            let sectionHeight = (self.itemSize.height + self.minimumLineSpacing) * CGFloat(self.rowForSection(i)) + self.sectionInset.bottom + self.sectionInset.top - self.minimumLineSpacing
            
            
            height += sectionHeight
            //添加段头和段尾高度
        }
        
        height = height + self.headerReferenceSize.height * CGFloat(self.collectionView!.numberOfSections())
        
        
        
        return CGSizeMake(width, height)
    }
    
    //MARK: - 计算装饰视图的属性,主要是的大小和位置
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let decorationAttr = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, withIndexPath: indexPath)
        
        let width = self.collectionView!.frame.size.width
        
        //计算每一个装饰视图的大小
        let height = (self.itemSize.height + self.minimumLineSpacing) * CGFloat(self.rowForSection(indexPath.section))  + self.sectionInset.bottom + self.sectionInset.top - self.minimumLineSpacing
        
        let attX   = CGFloat(0)
        //计算每一个装饰视图的位置
        var v:CGFloat = 0
        for i in 0 ..< indexPath.section {
            v += (self.itemSize.height + self.minimumLineSpacing) * CGFloat(self.rowForSection(i))  + self.sectionInset.bottom + self.sectionInset.top - self.minimumLineSpacing + self.headerReferenceSize.height
        }
        let attY   =  v
        
        
        decorationAttr.frame = CGRectMake(attX, attY  + self.headerReferenceSize.height, width, height)
        //设置纵深,-1为其他视图之下
        decorationAttr.zIndex = -1
        
        
        
        self.attributes.append(decorationAttr)
        
        
        
        return decorationAttr
    }
    
    //MARK: - 计算每个要显示item的属性,主要是位置
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        
        let itemArr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let itemWidth = self.itemSize.width
        let itemHeight = self.itemSize.height
        
        //每个item的x坐标
        //左边距 + (第几个item) * item的大小(该大小已包含item的左右间距)
        let itemX = self.sectionInset.left + CGFloat(indexPath.item) % CGFloat(self.numberOfColumn) * (itemWidth + self.minimumInteritemSpacing)
        
        //计算item的位置
        //height的主要作用是用来计算每个item在当前section的位置,该位置和section无关
        let itemyInSection = (itemHeight + self.minimumLineSpacing) * CGFloat(indexPath.item / self.numberOfColumn) + CGFloat(indexPath.section) * self.headerReferenceSize.height + self.headerReferenceSize.height
        
        //每一段的行高
        var v:CGFloat = 0
        for i in 0 ..< indexPath.section {
            v += (self.itemSize.height + self.minimumLineSpacing) * CGFloat(self.rowForSection(i))  + self.sectionInset.bottom + self.sectionInset.top - self.minimumLineSpacing
        }
        
        var itemY = CGFloat(0)
        
        //计算当前item在整个collectionView的位置
        // 当前段 * 每一段的高度 + 段间距 + item所在section的位置
        itemY =  v + self.sectionInset.top + itemyInSection
        
        
        itemArr.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight)
        
        self.attributes.append(itemArr)
        
        return itemArr
        
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        

        var att:UICollectionViewLayoutAttributes?
        
        
        if elementKind == "header" {
            
            var v:CGFloat = 0
            for i in 0 ..< indexPath.section {
                v += (self.itemSize.height + self.minimumLineSpacing) * CGFloat(self.rowForSection(i))  + self.sectionInset.bottom + self.sectionInset.top - self.minimumLineSpacing + self.headerReferenceSize.height
            }
            
            
            att = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "header", withIndexPath: indexPath)
            
            att!.frame = CGRectMake(0, v, self.collectionView!.frame.size.width, self.headerReferenceSize.height)
            
            //            print(self.collectionView!.frame.size.width)
            
            self.attributes.append(att!)
            
        }
        
        
        return att
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        //因为在reload的时候,需要重新设置每个item的属性,所以需要将以往的属性先删除
        self.attributes.removeAll()
        
        let sectionNumber = self.collectionView!.numberOfSections()
        
        for i in 0 ..< sectionNumber
        {
            
            // 装饰视图属性
            let indexPath = NSIndexPath(forItem: 0, inSection: i)
            self.layoutAttributesForDecorationViewOfKind("DD", atIndexPath: indexPath)
            
            self.layoutAttributesForSupplementaryViewOfKind("header", atIndexPath: indexPath)
            
            // 某个分区内的item总数
            let items = self.collectionView!.numberOfItemsInSection(i)
            
            for item in 0 ..< items
            {
                let itemPath = NSIndexPath(forItem: item, inSection: i)
                
                
                self.layoutAttributesForItemAtIndexPath(itemPath)
                
            }
        }
        
        return self.attributes
    }
    
    private func rowForSection(section:Int) -> Int {
        
        var row = self.collectionView!.numberOfItemsInSection(section) / self.numberOfColumn
        
        if self.collectionView!.numberOfItemsInSection(section) % self.numberOfColumn != 0 {
            row += 1
        }
        
        
        return row
    }
    
    
}








