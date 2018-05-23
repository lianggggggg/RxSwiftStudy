//
//  ProgressHUD.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import SVProgressHUD


enum HUDType {
    case succrss
    case error
    case loading
    case info
    case progress
}

class ProgressHUD: NSObject {

    class func initProgressHUD(){
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    class func showSuccess(_ status:String){
        self.showProgressHUD(type: .succrss, status: status)
    }
    class func showError(_ status:String){
        self.showProgressHUD(type: .error, status: status)
    }
    class func showLoading(_ status:String){
        self.showProgressHUD(type: .loading, status: status)
    }
    class func showInfo(_ status:String){
        self.showProgressHUD(type: .info, status: status)
    }
    class func showProgress(_ status:String, _ progress:Float = 0){
        self.showProgressHUD(type: .progress, status: status, progress: progress)
    }
    class func dismissHUD(_ delay: TimeInterval = 0){
        SVProgressHUD.dismiss(withDelay: delay)
    }
}


extension ProgressHUD{
    class func showProgressHUD(type:HUDType,status:String,progress:Float = 0){
        switch type {
        case .succrss:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(progress, status: status)
        }
    }
}
