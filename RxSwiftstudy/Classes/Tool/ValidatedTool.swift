//
//  ValidatedTool.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/28.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork


/// 验证手机号是否合法
///
/// - Parameter mobileNum: 手机号码
/// - Returns: true/false
func isMobileNum(_ mobileNum:String) -> Bool{
    let MOBILE = "^1(3[0-9]|4[579]|5[0-35-9]|7[0135-8]|8[0-9])\\d{8}$"
    let regextest = NSPredicate.init(format: "SELF MATCHES %@", MOBILE)
    return regextest.evaluate(with: mobileNum)
}

/// 检查邮箱是否合法
///
/// - Parameter email: 检查字符串
/// - Returns: true/false
func isValidateEmail(_ email:String) -> Bool{
    let EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let regextest = NSPredicate.init(format: "SELF MATCHES %@", EMAIL)
    return regextest.evaluate(with: email)
}

/// 检验是否为大写字母
///
/// - Parameter capital: 检查字符串
/// - Returns: true/false
func isCapital(_ capital:String) -> Bool{
    
    let CAPITAL = "[A-Z]+"
    let regextest = NSPredicate.init(format: "SELF MATCHES %@", CAPITAL)
    
    return regextest.evaluate(with: capital)
}


/// 检验是否为小写字母
///
/// - Parameter latter: 检查字符串
/// - Returns: true/false
func isLetter(_ latter:String) -> Bool{
    let LETTER = "[a-z]+"
    let regextest = NSPredicate.init(format: "SELF MATCHES %@", LETTER)
    return regextest.evaluate(with: latter)
}

/// 检查是否为数字
///
/// - Parameter number: 检查字符串
/// - Returns: true/false
func isHaveNum(_ number:String) -> Bool{
    let NUMBER = "[0-9]+"
    let regextest = NSPredicate.init(format: "SELF MATCHES %@", NUMBER)
    return regextest.evaluate(with: number)
}

/// 检查是否含有特殊字符
///
/// - Parameter character: 检查字符串
/// - Returns: true/false
//func isCharacter(_ character:String) -> Bool{
//
//    let CHARACTER = "((?=[\\x21-\\x7e]+)[^A-Za-z0-9])+"
//    let regextest = NSPredicate.init(format: "SELF MATCHES %@", CHARACTER)
//
//    return regextest.evaluate(with: character)
//}


/// 检验密码长度  ->必须数字加字母可 长度 8-12
///
/// - Parameter passWord: 检查字符串
/// - Returns: true/false
func isPasswordLength(_ passWord:String) -> Bool{
    
    let PASSWORD = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,12}"
    let regextest = NSPredicate.init(format: "SELF MATCHES %@", PASSWORD)
    return regextest.evaluate(with: passWord)
}









