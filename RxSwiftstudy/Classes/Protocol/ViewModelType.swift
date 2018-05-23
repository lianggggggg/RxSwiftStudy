//
//  ViewModelType.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transfrom(input: Input) -> Output
}
