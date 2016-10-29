//
//  DaoProtocol.swift
//  diaodiao
//
//  Created by honey on 16/5/20.
//  Copyright © 2016年 honey. All rights reserved.
//

import Foundation

//回调函数,数据都使用数组或者字典保存,然后传递给用户
public typealias Callback = (_:Any) -> Void

//数据操作接口,所有数据操作都必须遵守该协议,并且实现以下方法
protocol CommonDataOperation {
    
    func findAllWithNetwork (parameters:Dictionary<String, AnyObject>?, _ result:Callback) -> Void
    func findAllWithDatabase(parameters:Dictionary<String, AnyObject>?, _ result:Callback) -> Void
    func findAllWithOtherWay(parameters:Dictionary<String, AnyObject>?, _ result:Callback) -> Void
}


//MARK: - 通用数据操作
enum CommonDataOperationE {
    //选择数据的来源
    case network(Callback)
    case database(Callback)
    case other(Callback)
    
    //执行请求,这里需要指定执行何种请求,使用泛型来约束该参数必须遵守CommonOperation协议
    //op参数为具体协议的实现者
    func fetchRequestWith<T:CommonDataOperation>(let op:T, let _ pa:Dictionary<String, AnyObject>? = nil) {
        switch self {
        case let .database(callback):
            op.findAllWithDatabase(pa, callback)
        case let .network(callback):
            op.findAllWithNetwork(pa, callback)
        case let .other(callback):
            op.findAllWithOtherWay(pa, callback)
        }
    }
}





