//
//  NetWorkTool.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit

import Moya

enum NetWorkTool {
    enum NetWorjCategory:String {
        case all = "all"
        case welfare = "福利"
    }
    
    case data(type:NetWorjCategory,pageSize:Int,pageNum:Int)
}

extension NetWorkTool:TargetType{
    var baseURL: URL {
        return URL.init(string: "http://gank.io/api/data/")!
    }
    
    var path: String {
        switch self {
        case let .data(type, pageSize, pageNum):
            return "\(type.rawValue)/\(pageSize)/\(pageNum)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return sampleData
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }

}

let netTool = MoyaProvider<NetWorkTool>().rx


