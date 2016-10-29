//
//  DiscoveryCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/5/5.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation

extension DiscoveryCollectionCell {
    
    func configureCell(node:Node) {
        
        self.title?.text = node.name
    }
    
}
