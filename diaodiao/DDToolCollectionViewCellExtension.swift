//
//  DDToolCollectionViewCellExtension.swift
//  diaodiao
//
//  Created by honey on 16/4/26.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation

extension DDToolCollectionViewCell {

    func configureCell(model:Tool) -> Void {
        self.title.text = model.text
        self.imageView.sd_setImageWithURL(NSURL(string: model.pic)) { (_, _, _, _) in
            self.imageView.contentScaleFactor = UIScreen.mainScreen().scale
        }
 
    }
    
}