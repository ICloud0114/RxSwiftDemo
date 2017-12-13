//
//  DateTimePickerView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

protocol DateTimePickerViewDelegate {
    func didFinishSelectDateTime(dateTime: String)
    func didCancelSelectDateTime()
}
class DateTimePickerView: UIView {

    var contentView: UIView!
    var pickerView: UIPickerView!
    var cancelButton: UIButton!
    var chooseButton: UIButton!
    
    var startYear: Int = Date().year
    var year: Int = Date().year
    var month: Int = Date().month
    var day: Int = Date().day
    var hour: Int = Date().hour
    
    var dayRange: Int = 0
    var delegate: DateTimePickerViewDelegate?
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.alpha = 0
        
         contentView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 220))
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 180))
        pickerView.backgroundColor = .white

        pickerView.dataSource = self
        pickerView.delegate = self
        
        contentView.addSubview(pickerView)
        //盛放按钮的View
        let upView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        upView.backgroundColor = .white
        contentView.addSubview(upView)
        //左边的取消按钮
        
        cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: 12, y: 0, width: 40, height: 40)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelButton.setTitleColor(.blue, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        upView.addSubview(cancelButton)
        
        //右边的确定按钮
        chooseButton = UIButton(type: .custom)
        chooseButton.frame = CGRect(x: self.bounds.width - 52, y: 0, width: 40, height: 40)
        chooseButton.setTitle("确定", for: .normal)
        chooseButton.backgroundColor = .clear
        chooseButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        chooseButton.setTitleColor(.blue, for: .normal)
        chooseButton.addTarget(self, action: #selector(configButtonClick), for: .touchUpInside)
        upView.addSubview(chooseButton)
        
        //分割线

        let splitLine = UIView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 0.5))
        splitLine.backgroundColor = UIColor.lightGray
        
        displayCurrentDateTime(Date())
        
    }
    
    func displayCurrentDateTime(_ date: Date) {
        
        dayRange = calculateAllDays(year: date.year, month: date.month)
        
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.pickerView.selectRow(date.month - 1, inComponent: 1, animated: false)
        self.pickerView.selectRow(date.day - 1, inComponent: 2, animated: false)
        self.pickerView.selectRow(date.hour , inComponent: 3, animated: false)
    }
    
    func calculateAllDays(year: Int, month: Int) -> Int {
        switch(month)
        {
        case 1, 3, 5, 7, 8, 10, 12:
       
            return 31
        case 4, 6, 9, 11:
            return 30

        case 2:
            if(((year % 4 == 0)&&(year % 100 != 0))||(year % 400 == 0))
            {
                return 29
            }
            else
            {
                return 28
            }
        default:
            return 0
        }
    }
    
    @objc func cancelButtonClick() {
        self.delegate?.didCancelSelectDateTime()
    }
    
    @objc func configButtonClick(){
        self.delegate?.didFinishSelectDateTime(dateTime: "\(year)/\(month)/\(day) \(hour):00")
    }
    
}

extension DateTimePickerView:UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return 10
        case 1:
            return 12
        case 2:
            return dayRange
        case 3:
            return 24
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: self.frame.width * CGFloat(component) / 6.0, y: 0, width: self.frame.width / 6.0, height: 30))
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.tag = component * 100 + row
        label.textAlignment = .center
        switch component {
        case 0:
            label.text = "\(startYear + row)年"
        case 1:
            label.text = "\(row + 1)月"
        case 2:
            label.text = "\(row + 1)日"
        case 3:
            label.text = "\(row)时"
        default:
            break
        }
        return label
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (self.frame.width - 40 ) / 4.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            year = startYear + row
            dayRange = calculateAllDays(year: year, month: month)
            pickerView.reloadComponent(2)
        case 1:
            month = row + 1
            dayRange = calculateAllDays(year: year, month: month)
            pickerView.reloadComponent(2)
        case 2:
            day = row + 1
        case 3:
            hour = row
        default:
            break
        }
    }

}

extension DateTimePickerView{
    
    func showDateTimePickerView() {
        
        displayCurrentDateTime(Date())
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.contentView.frame = CGRect(x: 0, y: self.bounds.height - 220, width: self.bounds.width, height: 220)
        }
    }
    
    func hideDateTimePickerView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.contentView.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 220)
        }) { (finish) in
            self.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.frame.height)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hideDateTimePickerView()
    }
}
