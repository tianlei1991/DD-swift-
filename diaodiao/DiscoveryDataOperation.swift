//
//  DiscoveryDataOperation.swift
//  diaodiao
//
//  Created by honey on 16/5/27.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DiscoveryDataOperation {
}

extension DiscoveryDataOperation: CommonDataOperation {
    
    func findAllWithDatabase(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
        
    }
    
    func findAllWithNetwork(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
    }
    
    //MARK: - 从其他地方获取
    func findAllWithOtherWay(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
        
        self.readConfig(result)
    }
    
    //解析配置文件
    private func readConfig(callback: Callback) {
        
        let discoverBundlePath = NSBundle.mainBundle().pathForResource("discover", ofType: "bundle")
        
        let bundle = NSBundle(path: discoverBundlePath!)
        
        let jsonPath = bundle?.pathForResource("discover", ofType: "json")
        
        let data = NSData(contentsOfURL: NSURL(fileURLWithPath: jsonPath!))
        
        let s = String.init(data: data!, encoding: NSUTF8StringEncoding)
        
        let result = JSON.parse(s!)

        let layout = result["tags"]["layout"].arrayValue
        
        let meta = result["tags"]["meta"]
        var items = [Discovery]()
        
        for v in layout {
            
            
            let l1 = v["l1"].stringValue
            let l2 = v["l2"].arrayValue
            
            var discover = Discovery()
            
            discover.name = meta[l1]["name"].stringValue
            discover.tid = l1
            discover.background.type = meta[l1]["background"]["type"].stringValue
            discover.background.file = meta[l1]["background"]["file"].stringValue
            discover.backgroundDrawer.type = meta[l1]["background_drawer"]["type"].stringValue
            discover.backgroundDrawer.file = meta[l1]["background_drawer"]["file"].stringValue
            
            for n in l2 {
                var node = Node()
                node.name = meta[n.stringValue]["name"].stringValue
                node.tid = n.stringValue
                discover.node.append(node)
            }
            
            //预先计算每一行要显示内容的高度(不含头部图片)
            let nodeCount = discover.node.count
            
            let itemHeight = 80
            let itemWidth = 60
            //计算每一行的个数
            let width = Int(UIScreen.mainScreen().bounds.size.width)
            
            let row = width / (itemWidth + 5)
            
            var n = nodeCount / row
            
            if nodeCount % row != 0 {
                n += 1
            }
            
            discover.rowHeight = Double(itemHeight * n)

            items.append(discover)
            
            callback(items)
        }
    }
}