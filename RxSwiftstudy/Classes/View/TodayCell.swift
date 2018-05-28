//
//  TodayCell.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/24.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit
import Reusable

class TodayCell: UITableViewCell,NibReusable {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TodayCell{
    static func cellHeight() -> CGFloat{
        return (KScreenWidth - 40)*1.3+25
    }
}
