//
//  LimitViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class LimitViewController: UIViewController, DateTimePickerViewDelegate {

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var endButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    var dateTimePicker: DateTimePickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let format  = DateFormatter()
        format.dateFormat = "yyyy/MM/dd HH:00"
        startButton.setTitle(format.string(from: Date()), for: .normal)
        
        endButton.setTitle(format.string(from: Date().dateByAddingDays(1)!), for: .normal)
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
        
        print(startButton.titleLabel?.text)
        print(endButton.titleLabel?.text)
        
        let alertView = UIAlertView(
            title: "success",
            message: "password is ------",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
    
    @IBAction func selectDateTimeLimitAction(_ sender: UIButton){
        
        dateTimePicker = DateTimePickerView(frame: (self.view.window?.frame)!)
        dateTimePicker?.delegate = self
        self.view.window?.addSubview(dateTimePicker!)
        dateTimePicker?.showDateTimePickerView()
    }
    
    func didFinishSelectDateTime(dateTime: String){
        print("------->" + dateTime)
        dateTimePicker?.removeFromSuperview()
        dateTimePicker?.delegate = nil
        dateTimePicker = nil
    }
    
    func didCancelSelectDateTime(){
        dateTimePicker?.removeFromSuperview()
        dateTimePicker?.delegate = nil
        dateTimePicker = nil
    }
}
