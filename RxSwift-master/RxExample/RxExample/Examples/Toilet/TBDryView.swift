//
//  TBDryView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/22.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class TBDryView: UIView {
    
    typealias completeBlock = () -> ()
    typealias dryLevelBlock = (_ value : Int) -> ()
    
    @IBOutlet var adjustButton: UIButton!
    @IBOutlet var controlView: UIView!
    @IBOutlet var slideView: ZYSlideView!
    
    var complete: completeBlock?
    var levelBlock: dryLevelBlock?

    class func shareDryView() -> TBDryView {
        return Bundle.main.loadNibNamed("TBDryView", owner: nil, options: nil)?.last as! TBDryView
    }
    func showIn(view: UIView, level: Int) -> Void{
        let dryView = self
//        dryView.translatesAutoresizingMaskIntoConstraints = false
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(dryView)
        
        self.controlView.frame.origin.y += self.controlView.frame.height - self.adjustButton.frame.height / 2.0
        self.adjustButton.frame.origin.y += self.controlView.frame.height - self.adjustButton.frame.height / 2.0

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            self.controlView.frame.origin.y -= self.controlView.frame.height - self.adjustButton.frame.height / 2.0
            self.adjustButton.frame.origin.y -= self.controlView.frame.height - self.adjustButton.frame.height / 2.0
            
        }) { (finished) in
           self.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        }
        slideView.titles = ["常温", "低", "中", "高"]
        slideView.current = level
        slideView.selectValue = {[unowned self]
            value in
            self.levelBlock?(value)
        }
    }
    
    @IBAction func slideDownAction(sender: AnyObject) {
        
        dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        if touch.view == self{
            dismiss()
        }
    }
    
    func dismiss() -> Void {
        adjustButton.isSelected = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.layer.backgroundColor = UIColor.clear.cgColor
            self.controlView.frame.origin.y += self.controlView.frame.height - self.adjustButton.frame.height / 2.0
            self.adjustButton.frame.origin.y += self.controlView.frame.height - self.adjustButton.frame.height / 2.0
            
        }) { (finished) in
            self.removeFromSuperview()
            
            self.complete?()
        }
    }
    
}
