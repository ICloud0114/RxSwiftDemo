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
        
        let displayFormat = DateFormatter()
        displayFormat.dateFormat = "yyyy/MM/dd HH:00"
        
        let inputFormat = DateFormatter()
        inputFormat.dateFormat = "yyyyMMddHH"
        
        let start = displayFormat.date(from: (startButton.titleLabel?.text)!)
        let end = displayFormat.date(from: (endButton.titleLabel?.text)!)

        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        let hour: Int32 = Int32(gregorian!.components(NSCalendar.Unit.hour, from: start!, to: end!, options:(NSCalendar.Options(rawValue: 0))).hour!)
        
        print("start:" + (startButton.titleLabel?.text)!)
        print("end:" + (endButton.titleLabel?.text)!)
        print("hour: \(hour)")
        
        guard hour > 0 , hour < 744 else{
            let alertView = UIAlertView(
                title: "ERROR!",
                message: "时间相隔最小1小时,最长1个月",
                delegate: nil,
                cancelButtonTitle: "OK"
            )
            alertView.show()
            return
        }
        
        let result = EncryptionTest().createPassword(inputFormat.string(from: start!), hours: hour)
        
        if result != nil {
            let pwd:[Int] = result as! [Int]
            
            let passwordString  = pwd.reduce("", { (password, p) -> String in
                return password + "\(p)"
            })
            
            self.passwordLabel.text = "密码： " + passwordString
            print("password:" + passwordString)
        }else{
            self.passwordLabel.text = "ERROR"
        }
        
    }
    
    @IBAction func selectDateTimeLimitAction(_ sender: UIButton){
        
        dateTimePicker = DateTimePickerView(frame: (self.view.window?.frame)!)
        dateTimePicker?.delegate = self
        dateTimePicker?.tag = sender.tag
        
        self.view.window?.addSubview(dateTimePicker!)
        let displayFormat = DateFormatter()
        displayFormat.dateFormat = "yyyy/MM/dd HH:00"
        let current = displayFormat.date(from: (sender.titleLabel?.text)!)
        dateTimePicker?.showDateTimePickerView(currentDate: current!)
    }
    
    func didFinishSelectDateTime(dateTime: String, pickerView: DateTimePickerView) {
        print("------->" + dateTime)
        
        if pickerView.tag == startButton.tag {
            startButton.setTitle(dateTime, for: .normal)
        }else if pickerView.tag == endButton.tag{
            endButton.setTitle(dateTime, for: .normal)
        }
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
