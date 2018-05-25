//
//  ViewModelType.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit


// associatedtype 关键字 用来声明一个类型的占位符作为协议定义的一部分
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transfrom(input: Input) -> Output
}
