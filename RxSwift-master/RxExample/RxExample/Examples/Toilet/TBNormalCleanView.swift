//
//  TBNormalCleanView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/22.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class TBNormalCleanView: UIView {
    @IBOutlet var controlView: UIView!
    
    @IBOutlet var slideButton: UIButton!
    @IBOutlet var spaButton: UIButton!
    @IBOutlet var massageButton: UIButton!
    @IBOutlet var moveButton: UIButton!
    @IBOutlet var careBtn: UIButton!
    
    @IBOutlet var spaLabel: UILabel!
    @IBOutlet var massageLabel: UILabel!
    @IBOutlet var moveLabel: UILabel!
    @IBOutlet var careLabel: UILabel!
    
    @IBOutlet var temperatureSlideView: ZYSlideView!
    @IBOutlet var pressureSlideView: ZYSlideView!
    @IBOutlet var positionSlideView: ZYSlideView!
    @IBOutlet var timeSlideView: ZYSlideView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    class func shareNormalCleanView() -> TBNormalCleanView {
        return Bundle.main.loadNibNamed("TBNormalCleanView", owner: nil, options: nil)?.first as! TBNormalCleanView
    }
    
    class func shareFemaleCleanView() -> TBNormalCleanView{
        return Bundle.main.loadNibNamed("TBNormalCleanView", owner: nil, options: nil)?.last as! TBNormalCleanView
    }
    
    func showIn(view: UIView, data: (temperature: Int, pressure: Int, position: Int, time: Int)) -> Void{
        let clean = self
        //        dryView.translatesAutoresizingMaskIntoConstraints = false
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(clean)
        
        self.controlView.frame.origin.y += self.controlView.frame.height - self.slideButton.frame.height / 2.0
        self.slideButton.frame.origin.y += self.controlView.frame.height - self.slideButton.frame.height / 2.0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            self.controlView.frame.origin.y -= self.controlView.frame.height - self.slideButton.frame.height / 2.0
            self.slideButton.frame.origin.y -= self.controlView.frame.height - self.slideButton.frame.height / 2.0
            
        }) { (finished) in
            self.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        }

        temperatureSlideView.titles = ["OFF","32˚C","34˚C","36˚C","38˚C","40˚C"]
        pressureSlideView.titles = ["1档","2档","3档","4档","5档"]
        positionSlideView.titles = ["1档","2档","3档","4档","5档"]
        timeSlideView.titles = ["1 min","2 min","3 min","4 min"]
        
        temperatureSlideView.current = data.temperature
        pressureSlideView.current = data.pressure
        positionSlideView.current = data.position
        timeSlideView.current = data.time
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        if touch.view == self{
            dismiss()
        }
    }
    
    func dismiss() -> Void {
        
        slideButton.isSelected = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.layer.backgroundColor = UIColor.clear.cgColor
            self.controlView.frame.origin.y += self.controlView.frame.height - self.slideButton.frame.height / 2.0
            self.slideButton.frame.origin.y += self.controlView.frame.height - self.slideButton.frame.height / 2.0
            
        }) { (finished) in
            self.removeFromSuperview()
            
//            self.complete?()
        }
    }
   
}

extension TBNormalCleanView{
    
    @IBAction func slideDownAction(_ sender: UIButton){
        dismiss()
    }
    
    @IBAction func spaAction(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            self.spaLabel.isHidden = false
            self.temperatureSlideView.isHidden = true
            self.massageLabel.isHidden = false
            self.pressureSlideView.isHidden = true
            
            self.massageButton.isSelected = true
            self.massageButton.isUserInteractionEnabled = false
            
//            if (self.changeSPA) {
//                self.changeSPA(7, 6);
//            }
        }
        else
        {
            self.spaLabel.isHidden = true
            self.temperatureSlideView.isHidden = false
            self.massageLabel.isHidden = true
            self.pressureSlideView.isHidden = false
            self.massageButton.isSelected = false
            self.massageButton.isUserInteractionEnabled = true
            
//            if (self.changeSPA) {
//                self.changeSPA(self.temperatureSlideView.sectionIndex+ 1,  self.pressureSlideView.sectionIndex + 1);
//            }
        }
    }
    
    @IBAction func massageAction(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            self.massageLabel.isHidden = false
            self.pressureSlideView.isHidden = true
//            if (self.changePressure) {
//                self.changePressure(5);
//            }
        }
        else
        {
            self.massageLabel.isHidden = true
            self.pressureSlideView.isHidden = false
//            if (self.changePressure) {
//                self.changePressure(self.pressureSlideView.sectionIndex );
//            }
        }
    }
    
    @IBAction func moveAction(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            self.moveLabel.isHidden = false
            self.positionSlideView.isHidden = true
//            if (self.changePosition) {
//                self.changePosition(5);
//            }
        }
        else
        {
            self.moveLabel.isHidden = true
            self.positionSlideView.isHidden = false
//            if (self.changePosition) {
//                self.changePosition(self.positionSlideView.sectionIndex );
//            }
        }
    }
    
    @IBAction func careAction(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        if (sender.isSelected) {
            self.careLabel.isHidden = false
            self.temperatureSlideView.isHidden = true
//            if (self.changeTemperature) {
//                self.changeTemperature(7);
//            }
        }
        else
        {
            self.careLabel.isHidden = true
            self.temperatureSlideView.isHidden = false
//            if (self.changeTemperature) {
//                self.changeTemperature(self.temperatureSlideView.sectionIndex);
//            }
        }
    }
    
}
