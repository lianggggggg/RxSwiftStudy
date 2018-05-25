//
//  RegisterViewController.swift
//  RxSwiftstudy
//
//  Created by admin on 2018/5/23.
//  Copyright © 2018年 MrLiang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var passWordLbl: UILabel!
    
    @IBOutlet weak var repateTxt: UITextField!
    @IBOutlet weak var repateLbl: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
