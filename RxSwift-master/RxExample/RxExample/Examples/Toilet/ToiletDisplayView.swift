//
//  ToiletDisplayView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/17.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class ToiletDisplayView: UIView {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tipTemperature: UILabel!
    @IBOutlet var tipPressure: UILabel!
    @IBOutlet var tipPosition: UILabel!
    @IBOutlet var tipTime: UILabel!
    @IBOutlet var tipDry: UILabel!
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var loadingImage: UIImageView!
    
    @IBOutlet var iconTemperature: UIImageView!
    @IBOutlet var iconPressure: UIImageView!
    @IBOutlet var iconPosition: UIImageView!
    @IBOutlet var iconTime: UIImageView!
    @IBOutlet var iconDry: UIImageView!
    
    lazy var progressLayer: CAShapeLayer = {
        let layer: CAShapeLayer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.strokeEnd = 0.0
        layer.lineWidth = 3.5
        layer.lineJoin = kCALineJoinRound
        layer.lineCap = kCALineCapRound
        let center: CGPoint = CGPoint(x: self.loadingImage.frame.width / 2.0, y: self.loadingImage.frame.width / 2.0)
        let bezierPath: UIBezierPath = UIBezierPath(
            arcCenter: center,
            radius: self.loadingImage.frame.width / 2.0,
            startAngle: CGFloat(-90 * Double.pi / 180.0),
            endAngle: CGFloat(270 * Double.pi / 180.0),
            clockwise: true)
        layer.path = bezierPath.cgPath
        return layer
    }()
    
    lazy var progressBackgroundLayer: CAShapeLayer = {
        let layer: CAShapeLayer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        layer.strokeEnd = 1.0
        layer.lineWidth = 1.5
        let center: CGPoint = CGPoint(x: self.loadingImage.frame.width / 2.0, y: self.loadingImage.frame.width / 2.0)
        let bezierPath: UIBezierPath = UIBezierPath(
            arcCenter: center,
            radius: self.loadingImage.frame.width / 2.0,
            startAngle: CGFloat(-90 * Double.pi / 180.0),
            endAngle: CGFloat(270 * Double.pi / 180.0),
            clockwise: true)
        layer.path = bezierPath.cgPath
        return layer
    }()
}

extension ToiletDisplayView{
    
    func showProgressView(progress: CGFloat ,type: OperationType) {
        
        self.loadingImage.layer.addSublayer(self.progressLayer)
        self.loadingImage.layer.addSublayer(self.progressBackgroundLayer)
        progressLayer.strokeEnd = progress
        
        switch type {
            case .stop:
                self.showDefaultView()
            case .normalClean:
                self.showNormalClean()
            case .femaleClean:
                self.showFemaleClean()
            case .dry:
                self.showDry()
            case .childClean:
                self.showChildClean()
            case .femaleAuto:
                self.showFemaleAutoClean()
            case .maleAuto:
                self.showMaleAutoClean()
        }
    }
}

extension ToiletDisplayView{
    func showNormalClean(){
        self.logo.isHidden = true
        self.tipDry.isHidden = true
        self.iconDry.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "臀部洗净中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_1")
        
        self.iconTemperature.isHidden = false
        self.iconTemperature.image = UIImage(named: "info_operate_temperature")
        self.iconPressure.isHidden = false
        self.iconPressure.image = UIImage(named: "info_operate_pressure")
        self.iconPosition.isHidden = false
        self.iconTime.isHidden = false
        
        self.tipTemperature.isHidden = false
        self.tipPressure.isHidden = false
        self.tipPosition.isHidden = false
        self.tipTime.isHidden = false
    }
    
    func showFemaleClean(){
        self.logo.isHidden = true
        
        self.tipDry.isHidden = true
        self.iconDry.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "女性洗净中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_2")
        self.iconTemperature.isHidden = false
        self.iconTemperature.image = UIImage(named: "info_operate_temperature")
        self.iconPressure.isHidden = false
        self.iconPressure.image = UIImage(named: "info_operate_pressure")
        self.iconPosition.isHidden = false
        self.iconTime.isHidden = false
        
        self.tipTemperature.isHidden = false
        self.tipPressure.isHidden = false
        self.tipPosition.isHidden = false
        self.tipTime.isHidden = false
    }
    
    func showDry(){
        self.logo.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "烘干中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_3")
        self.iconTemperature.isHidden = false
        self.iconTemperature.image = UIImage(named: "info_operate_wind")
        self.iconPressure.isHidden = false
        self.iconPressure.image = UIImage(named: "info_operate_time")
        
        self.iconPosition.isHidden = true
        self.iconTime.isHidden = true
        self.tipDry.isHidden = true
        
        self.tipTemperature.isHidden = false
        self.tipPressure.isHidden = false
        self.tipPressure.text = "4min"
        
        self.tipPosition.isHidden = true
        self.tipTime.isHidden = true
        self.iconDry.isHidden = true
    }
    
    func showFlushing(){
        self.logo.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "冲水中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_4")
        self.iconTemperature.isHidden = true
        self.iconPressure.isHidden = true
        self.iconPosition.isHidden = true
        self.iconTime.isHidden = true
        self.iconDry.isHidden = true
        
        self.tipTemperature.isHidden = true
        self.tipPressure.isHidden = true
        self.tipPosition.isHidden = true
        self.tipTime.isHidden = true
        self.tipDry.isHidden = true
    }
    
    func showChildClean(){
        self.logo.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "儿童专用中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_5")
        self.iconTemperature.isHidden = false
        self.iconTemperature.image = UIImage(named: "info_operate_temperature")
        self.iconPressure.isHidden = false
        self.iconPressure.image = UIImage(named: "info_operate_pressure")
        self.iconPosition.isHidden = false
        self.iconTime.isHidden = false
        self.iconDry.isHidden = false
        
        self.tipTemperature.isHidden = false
        self.tipPressure.isHidden = false
        self.tipPosition.isHidden = false
        self.tipTime.isHidden = false
        self.tipDry.isHidden = false
    }
    
    func showMaleAutoClean(){
        self.logo.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "男性全自动中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_6")
        self.iconTemperature.isHidden = false
        self.iconTemperature.image = UIImage(named: "info_operate_buttock")
        self.iconPressure.isHidden = false
        self.iconPressure.image = UIImage(named: "info_operate_dry")
        
        self.iconPosition.isHidden = true
        self.iconTime.isHidden = true
        self.iconDry.isHidden = true
        
        self.tipTemperature.isHidden = false
        self.tipPressure.text = "1min"
        self.tipPressure.isHidden = false
        self.tipPressure.text = "4min"
        
        self.tipPosition.isHidden = true
        self.tipTime.isHidden = true
        self.tipDry.isHidden = true
    }
    
    func showFemaleAutoClean(){
        self.logo.isHidden = true
        
        self.loadingImage.isHidden = false
        self.titleLabel.isHidden = false
        self.titleLabel.text = "女性全自动中..."
        self.loadingImage.image = UIImage(named: "tolit_loading_7")
        self.iconTemperature.isHidden = false
        self.iconTemperature.image = UIImage(named: "info_operate_woman")
        self.iconPressure.isHidden = false
        self.iconPressure.image = UIImage(named: "info_operate_dry")
        
        self.iconPosition.isHidden = true
        self.iconTime.isHidden = true
        self.iconDry.isHidden = true
        
        self.tipTemperature.isHidden = false
        self.tipPressure.text = "1min"
        self.tipPressure.isHidden = false
        self.tipPressure.text = "4min"
        
        self.tipPosition.isHidden = true
        self.tipTime.isHidden = true
        self.tipDry.isHidden = true
    }
    
    func showDefaultView(){
        self.logo.isHidden = false
        
        self.loadingImage.isHidden = true
        self.titleLabel.isHidden = true
        
        self.iconTemperature.isHidden = true
        self.iconPressure.isHidden = true
        self.iconPosition.isHidden = true
        self.iconTime.isHidden = true
        self.iconDry.isHidden = true
        
        self.tipTemperature.isHidden = true
        self.tipPressure.isHidden = true
        self.tipPosition.isHidden = true
        self.tipTime.isHidden = true
        self.tipDry.isHidden = true
    }
}
