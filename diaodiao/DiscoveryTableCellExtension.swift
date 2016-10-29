//
//  DiscoveryTableCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/5/11.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation

extension DiscoveryTableCell {
    
    func configureCell(model:Discovery)  {
        
        self.model = model
        
        self.collectionTitle.text = model.name
        self.backgroundImageView.image = UIImage(named: "discover.bundle/" + model.background.file)
        self.backgroundImageBlur.image = UIImage(named: "discover.bundle/" + model.backgroundDrawer.file)
        
        self.reloadCollectionView()
    }
    
    
    func reloadCollectionView()  {
        self.collectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let callback = self.didCollectionViewItemSelected {
                        
            let node = self.model!.node[indexPath.row]

            callback(node)
        }
        
        
    }
    
    //MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let discovery = self.model {
            return discovery.node.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! DiscoveryCollectionCell
        
        if let discovery = self.model {
            let model = discovery.node[indexPath.row]
            c.configureCell(model)
        }
        
        return c
    }
    
}

