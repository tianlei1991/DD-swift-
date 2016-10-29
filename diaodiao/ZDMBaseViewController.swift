//
//  ZDMBaseViewController.swift
//  diaodiao
//
//  Created by honey on 16/5/4.
//  Copyright © 2016年 honey. All rights reserved.
//

import UIKit

import SwiftyJSON
import Alamofire

class ZDMBaseViewController: DDBaseViewController {
    
    var feed_list:[String]? = nil //item的顺序列表
    var items:Dictionary<String, ZDM>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

typealias ZDDataRequest = ZDMBaseViewController
extension ZDDataRequest {
    
    
    
    //MARK: - 请求数据
    func requestData( success: () -> () ) {
        
        CommonDataOperationE.network {
            
            let result = $0 as! Dictionary<String, Any>
            
            let list = result["feed_list"] as! Array<String>
            let it   = result["items"] as! Dictionary<String, ZDM>
            
            self.feed_list = list //确定cell上数据的顺序,每个元素都是item的cid属性
            self.items     = it
            
            success() //回调
            
        }.fetchRequestWith(ZDMDataOperation())

    }
}
