//
//  Function.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit

//设置rgb颜色
func UIColorFormRGBA(_ rgb:UInt,_ alpha:CGFloat = 1.0) -> UIColor{
    
    return UIColor(
        red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgb & 0x0000FF) / 255.0,
        alpha: alpha
    ) 
}

//加载storyboard的VC
func loadStoryBoardVC(_ storyName:String, _ identifier:String) -> UIViewController{
    return UIStoryboard.init(name: storyName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
}
