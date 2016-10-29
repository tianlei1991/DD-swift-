//
//  ItemInfo.swift
//  diaodiao
//
//  Created by honey on 16/4/14.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ItemInfo: BaseType {
    
    var ctype           = 0
    var latest_version  = 0
    
    var title_color     = 0
    var cid             = ""
    
    var url             = ""
    var price           = ""
    var coverv3         = ""
    var cover_image_url = ""
    var nid             = ""
    var thumb_image_url = ""
    var tag             = ""
    var banner          = ""
    var buylink         = ""
    
    var has_buylink     = false
    var is_external     = false
    
    var title           = [String]()
    var author          = [String:String]()
    
    init (_ dict: JSON) {
        self.cover_image_url = dict["cover_image_url"].stringValue
        self.coverv3         = dict["coverv3"].stringValue
        self.latest_version  = dict["latest_version"].intValue
        self.is_external     = dict["is_external"].boolValue
        self.ctype           = dict["ctype"].intValue
        
        self.nid             = dict["nid"].stringValue
        self.url             = dict["url"].stringValue
        self.title_color     = dict["title_color"].intValue
        self.cid             = dict["cid"].stringValue
        
        self.price           = dict["price"].stringValue
        self.tag             = dict["tag"].stringValue
        self.thumb_image_url = dict["thumb_image_url"].stringValue
        self.has_buylink     = dict["has_buylink"].boolValue
        self.banner          = dict["banner"].stringValue
        
        self.buylink         = dict["buylink"].stringValue
        
        for (k, v) in dict["author"].dictionaryValue {
            self.author[k] = v.stringValue
        }
        
        for i in dict["title"].arrayValue {
            self.title.append(i.stringValue)
        }


    }
    
}