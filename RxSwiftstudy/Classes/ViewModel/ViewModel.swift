//
//  ViewModel.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Moya


enum refreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class ViewModel: NSObject {
    
    let models = Variable<[Model]>([])
    var pageNum:Int = 1
    
}


extension ViewModel:ViewModelType{

    //传入
    struct VmInPut {
        // 网络请求类型  -> case值
        let category:NetWorkTool.NetWorjCategory
        init(category:NetWorkTool.NetWorjCategory) {
            self.category = category
        }
    }
    //传出
    struct VmOutPut {
        // tableView的sections数据
        let sections:Driver<[sectionModel]>
        // 外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        //传出刷新状态
        let refreshStatus = Variable<refreshStatus>(.none)
        
        init(sections:Driver<[sectionModel]>) {
            self.sections = sections
        }
        
    }
    
    
    

    typealias Input = VmInPut
    
    func transfrom(input: ViewModel.VmInPut) -> ViewModel.VmOutPut {
        
        let sections = models.asObservable().map { (models) -> [sectionModel] in
            // 当models的值被改变时会调用
            return [sectionModel(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        let outPut = VmOutPut(sections: sections)

        outPut.requestCommond.subscribe(onNext: {[unowned self] isReloadData in
            
            self.pageNum = isReloadData ? 1 : self.pageNum + 1
            
            netTool.request(NetWorkTool.data(type: input.category, pageSize: 10, pageNum: self.pageNum)).asObservable().mapArray(Model.self).subscribe {[weak self] (event) in
                switch event {
                case let .next(modelArr):
                    self?.models.value = isReloadData ? modelArr : (self?.models.value ?? []) + modelArr
                    ProgressHUD.showSuccess("加载完成")
                case let .error(error):
                    ProgressHUD.showError(error.localizedDescription)
                case let .completed:
                    outPut.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
                }
                }.disposed(by: self.rx.disposeBag)
            
        }).disposed(by: self.rx.disposeBag)
        
        return outPut
    }
    
    
}
