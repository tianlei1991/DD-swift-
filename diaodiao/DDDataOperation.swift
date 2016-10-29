//
//  DDDao.swift
//  diaodiao
//
//  Created by honey on 16/5/20.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON



//数据层封装，封装数据的来源
public enum DDResultKey: String {
    case DD_ORDER_LIST = "order_list"
    case DD_ITEMS      = "items"
    case DD_TOOL       = "tool"
    case DD_CAROUSELS  = "carousels"
}

//MARK: - 数据操作
struct DDDataOperation {
}




//MARK: - 实现CommonDao协议
extension DDDataOperation: CommonDataOperation  {
    
    //MARK: - 从网络请求数据
     func findAllWithNetwork(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) ->Void {
        
        let dict = [
                    "request_data": [
                        "init_meta_data" : ["count": -1,"version_id": 7979],
                        "feed_order_data": ["start": 0, "count": 1000]
                    ],
                    "request_methods": ["init_meta_data", "feed_order_data"]
        ]
        
        let api = Interfaces.kHome.api()
        
        NetworkHelper.request(requestURL: api, parameters: dict) { (value, error) in
            
            guard error == nil else {
                print(error)
                return
            }
            
            
            let json = JSON(value!)
            
            let meta_infos  = json["res"]["init_meta_data"]["meta_infos"].arrayValue
            let carousel    = json["res"]["feed_order_data"]["carousel"].arrayValue
            let tool        = json["res"]["feed_order_data"]["tool"].arrayValue
            let order_list  = json["res"]["feed_order_data"]["order_list"].arrayValue
            var order = [String]()
            
            var items = Dictionary<String, ItemInfo>()
            var tools = [Tool]()
            var carousels = [ItemInfo]()
            
            for info in meta_infos {
                
                let item = ItemInfo(info)
                
                items[item.cid] = item
                

            }
            
            for item in tool {
                
                let t = Tool(item)
                
                tools.append(t)
            }
            
            for cid in carousel {
                
                let item = items[cid.stringValue]!
                
                carousels.append(item)
            }
            
            for o in order_list {
                order.append(o.stringValue)
            }
            
            //回调结果
            let x:Dictionary<String, Any> = [DDResultKey.DD_ORDER_LIST.rawValue:    order,
                                             DDResultKey.DD_ITEMS.rawValue:         items,
                                             DDResultKey.DD_TOOL.rawValue:          tools,
                                             DDResultKey.DD_CAROUSELS.rawValue:     carousels]
            result(x)
        }
    }
    
    
    //MARK: - 从数据库请求数据
    func findAllWithDatabase(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) -> Void {
    }
    
    //MARK: - 从其他地方获取
    func findAllWithOtherWay(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
    }
}










