//
//  RegisterViewModel.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Moya

enum ResultState {
    case success
    case failur
    case empty
}


class RegisterViewModel {

    let result:Driver<ResultState>
    
    init(result:Driver<ResultState>) {
        self.result = result
    }
    
}

//extension RegisterViewModel:ViewModelType{
//
//    struct RegisterInPut{
//        let userName = Variable<String>("")
//        let passWord = Variable<String>("")
//        let repeatPass = Variable<String>("")
//    }
//
//    struct RegisterOutPut {
//        let userNameUsable:Observable<ResultState>
//        let passWordUsable:Observable<ResultState>
//        let repeatPass:Observable<ResultState>
//        let resule:Observable<ResultState>
//        let registerBtnEnable:Observable<Bool>
//    }
//
//    typealias Input = RegisterInPut
//
//    typealias Output = RegisterOutPut
//
//    func transfrom(input: RegisterViewModel.RegisterInPut) -> RegisterViewModel.RegisterOutPut {
//
//
//
//        
//
//        return Output.init(userNameUsable: <#T##Observable<ResultState>#>, passWordUsable: <#T##Observable<ResultState>#>, repeatPass: <#T##Observable<ResultState>#>, resule: <#T##Observable<ResultState>#>, registerBtnEnable: <#T##Observable<Bool>#>)
//
//    }
//
//
//
//
//}

