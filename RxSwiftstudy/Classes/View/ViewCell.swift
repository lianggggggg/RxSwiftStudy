//
//  ViewCell.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/22.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import Reusable

class ViewCell: UITableViewCell,NibReusable {

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ViewCell{
    
    static func cellHeight() -> CGFloat{
        return 240
    }
    
}

