//
//  Function.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit




/// 设置rgb颜色
///
/// - Parameters:
///   - rgb: rgb值 如:0x3366cc
///   - alpha: alpha值
/// - Returns: color
func UIColorFormRGBA(_ rgb:UInt,_ alpha:CGFloat = 1.0) -> UIColor{
    
    return UIColor(
        red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgb & 0x0000FF) / 255.0,
        alpha: alpha
    ) 
}

/// 加载storyboard的VC
///
/// - Parameters:
///   - storyName: storyName
///   - identifier: identifier
/// - Returns: UIViewController
func loadStoryBoardVC(_ storyName:String, _ identifier:String) -> UIViewController{
    return UIStoryboard.init(name: storyName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
}


/// 根据Label上string和宽带获取size
///
/// - Parameters:
///   - string: 检查字符串
///   - font: 字体大小
///   - viewWidth: 宽带
/// - Returns: label按字符串的大小
func getLabelSizeWith(_ string:String,_ font:UIFont,_ viewWidth:CGFloat = CGFloat(MAXFLOAT)) -> CGSize{
    
    var labelSize:CGSize
    
    labelSize = (string as NSString).boundingRect(with: CGSize.init(width: viewWidth, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading,.truncatesLastVisibleLine,.usesLineFragmentOrigin], attributes: [.font:font], context: nil).size
    return labelSize
}

/// 获取wifi名字
///
/// - Returns: wifi名称
func getWIFIName() -> String?{
    
    var wifiName:String? = nil
    
    let wifiInterfaces = CNCopySupportedInterfaces()
    guard (wifiInterfaces != nil) else {
        return nil
    }
    
    let interfaces = wifiInterfaces as! NSArray
    for interfaceName in interfaces {
        let dictRef = CNCopyCurrentNetworkInfo(interfaceName as! CFString)
        
        if dictRef != nil{
            let networkInfo = dictRef as! NSDictionary
            wifiName = networkInfo.object(forKey: kCNNetworkInfoKeySSID) as! String
        }
    }
    return wifiName
}


/// 字符串去(null)
///
/// - Parameter string: 输入
/// - Returns: 输出
func stringWithString(_ string:String) -> String{
    
    let temp = NSString.init(format: "%@", string)
    temp.replacingOccurrences(of: "(null)", with: "")
    temp.replacingOccurrences(of: "<null>", with: "")
    
    return temp as! String
}
