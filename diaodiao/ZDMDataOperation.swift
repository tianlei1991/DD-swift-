//
//  ZDMDataOperation.swift
//  diaodiao
//
//  Created by honey on 16/5/27.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation
import SwiftyJSON


//MARK: - 数据操作
struct ZDMDataOperation  {
}

//MARK: - 实现CommonDao协议
extension ZDMDataOperation: CommonDataOperation {
    
    //MARK: - 从网络请求数据
    func findAllWithNetwork(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) ->Void {
    
        let dict = [
            "method": "get_all",
            "client_data_version": 0//0表示为没有请求过数据
        ]
        
        let api = Interfaces.kZDM.api()
        
        
        NetworkHelper.request(requestURL: api, parameters: dict) { (value, error) in
            
            guard error == nil else {
                
                result(error)
                
                return
            }
            
            let json = JSON(value!)
            let list = json["res"]["feed_list"].arrayValue
            
            
            var feed_list = [String]()
            var items     = [String:ZDM]()
            
            for f in list {
                feed_list.append(f[0].stringValue) //确定cell上数据的顺序,每个元素都是item的cid属性
            }
            
            let meta_infos = json["res"]["meta_infos"].arrayValue
            
            for i in meta_infos {
                
                let zdm = ZDM(json: i)
                items[zdm.cid] = zdm
            }
            
            let x:[String:Any] = ["feed_list":feed_list,
                                  "items":items]

            result(x) //回调
            
        }
        
        
    }
    
    
    //MARK: - 从数据库请求数据
    func findAllWithDatabase(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) -> Void {
    }
    
    //MARK: - 从其他地方获取
    func findAllWithOtherWay(parameters:Dictionary<String, AnyObject>? = nil, _ result:Callback) {
    }
}
