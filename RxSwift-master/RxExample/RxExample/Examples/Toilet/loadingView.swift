//
//  loadingView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/23.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//
import UIKit

extension UIView{
    
    func repeatRotateAnimation(timeInterval: CGFloat) -> CABasicAnimation {
        
        let animate = CABasicAnimation(keyPath: "transform.rotation.z")
        animate.duration = CFTimeInterval(timeInterval)
        animate.isCumulative = true
        animate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animate.toValue = Double.pi * 4.0
        animate.repeatCount = 1
        return animate
    }
    
    func stopRepeatRotateAnimation() -> CABasicAnimation {
        let animate = CABasicAnimation(keyPath: "transform.rotation.z")
        animate.duration = 1
        animate.isCumulative = true
        animate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animate.toValue = 0.0
        animate.repeatCount = 1
        return animate
    }
    
    func startRepeatRotate(timeInterval: CGFloat) -> Bool {
        if self.layer.animation(forKey: "startRepeatRotateAnimation") == nil{
            let animation =  self.repeatRotateAnimation(timeInterval: timeInterval)
            self.layer.add(animation, forKey: "startRepeatRotateAnimation")
            return true
        }
        return false
    }
    
    func endRepeatRotate() -> Bool {
        if (self.layer.animation(forKey: "startRepeatRotateAnimation") != nil){
            self.layer.removeAnimation(forKey: "startRepeatRotateAnimation")
        }
        if self.layer.animation(forKey: "endRepeatRotateAnimation") == nil{
            let animation =  self.stopRepeatRotateAnimation()
            self.layer.add(animation, forKey: "endRepeatRotateAnimation")
            return true
        }
        return false
    }
}
