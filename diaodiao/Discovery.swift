//
//  DiscoveryRoot.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Discovery {
    
    var background = Background()
    var backgroundDrawer = Background()
    var name = ""
    var node = [Node]()
    
    var expand = false //用来记录当前段是否为折叠
    
    var tid = ""
    
    var rowHeight:Double = 0.0
    
    
}

struct Node {
    var tid = ""
    var name = ""
}

struct Background {
    var file = ""
    var type = ""
}

//商品状态
struct Status {
    var comment = 0
    var down    = 0
    var fav     = 0
    var up      = 0
    var click   = 0
    
    init (json:JSON) {
        self.comment = json["comment"].intValue
        self.down    = json["down"].intValue
        self.fav     = json["fav"].intValue
        self.up      = json["up"].intValue
        self.click   = json["click"].intValue
    }
}














