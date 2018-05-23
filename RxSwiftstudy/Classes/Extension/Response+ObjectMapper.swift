//
//  Response+ObjectMapper.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift


//MARK: JSON -> MODEL
extension Response{
    
    // 将Json解析为单个Model
    public func mapObject<T:BaseMappable>(_ type:T.Type) throws -> T{
        guard let object = Mapper<T>().map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }

    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T:BaseMappable>(_ type:T.Type) throws -> [T]{
        guard let json = try mapJSON() as? [String:Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let jsonArr = json["results"] as? [[String:Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>().mapArray(JSONArray: jsonArr)
    }
    
}

// MARK: - Json -> Observable<Model>
extension ObservableType where E == Response{
    
    // 将Json解析为Observable<Model>
    public func mapObject<T:BaseMappable>(_ type:T.Type) -> Observable<T>{
        return flatMap({ (response) -> Observable<T> in
            return Observable.just(try response.mapObject(T.self))
        })
    }
    
     // 将Json解析为Observable<[Model]>
    public func mapArray<T:BaseMappable>(_ type:T.Type) -> Observable<[T]>{
        return flatMap({ (response) -> Observable<[T]> in
            return Observable.just(try response.mapArray(T.self))
        })
    }
    
    
}


