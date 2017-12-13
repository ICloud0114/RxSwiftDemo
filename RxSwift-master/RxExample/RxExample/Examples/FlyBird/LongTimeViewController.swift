//
//  LongTimeViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class LongTimeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let format  = DateFormatter()
        format.dateFormat = "yyyy/MM/dd HH:00"
        startButton.setTitle(format.string(from: Date()), for: .normal)
        
        endButton.setTitle(format.string(from: Date().dateByAddinYears(1)!), for: .normal)
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
        let alertView = UIAlertView(
            title: "success",
            message: "password is ------",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
}
