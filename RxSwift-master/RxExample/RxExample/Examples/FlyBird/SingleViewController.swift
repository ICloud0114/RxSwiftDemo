//
//  SingleViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {

    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
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
    @IBAction func createPasswordAction(_ sender: Any) {
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMddHH"
        
        let result = EncryptionTest().createPassword(format.string(from: Date()), hours: 0)
        
        if result != nil {
            let pwd:[Int] = result as! [Int]
            
            let passwordString  = pwd.reduce("", { (password, p) -> String in
                return password + "\(p)"
            })
            
            self.passwordLabel.text = "密码： " + passwordString
        }else{
            self.passwordLabel.text = "ERROR"
        }
    }
}
