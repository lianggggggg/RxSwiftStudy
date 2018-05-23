//
//  Model.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import ObjectMapper
import RxDataSources

struct Model:Mappable {
    
    var _id         = ""
    var createdAt   = ""
    var desc        = ""
    var publishedAt = ""
    var source      = ""
    var type        = ""
    var url         = ""
    var used        = ""
    var who         = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        _id         <- map["_id"]
        createdAt   <- map["createdAt"]
        desc        <- map["desc"]
        publishedAt <- map["publishedAt"]
        source      <- map["source"]
        type        <- map["type"]
        url         <- map["url"]
        used        <- map["used"]
        who         <- map["who"]
        
    }
}

struct sectionModel {
    var items: [Model]
}

extension sectionModel:SectionModelType{

    typealias Item = Model
    
    init(original: sectionModel, items: [Model]) {
        self = original
        self.items = items
    }
}

