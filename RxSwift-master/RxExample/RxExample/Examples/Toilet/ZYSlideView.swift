//
//  ICSlideView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/20.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit
typealias valueBlock = (_ value : Int) -> ()
@IBDesignable
class ZYSlideView: UIControl {

    @IBInspectable var thumbOn: UIImage!
    
    @IBInspectable var minTrack: UIImage!
    
    @IBInspectable var maxTrack: UIImage!
    
    @IBInspectable var thumbBackgroundColor: UIColor = .black
    
    @IBInspectable var minTrackBackgroundColor: UIColor = .lightGray
    
    @IBInspectable var maxTrackBackgroundColor: UIColor = .blue
    
    @IBInspectable var titleColor: UIColor = .black
    
    @IBInspectable var titleHidden: Bool = false
    
    @IBInspectable var count: NSInteger = 2
    
    @IBInspectable var current: NSInteger = 0{
        didSet{
            if current >= count{
                current = count - 1
            }else if current < 0{
                current = 0
            }
        }
    }
    
    var titles: [String]?
    
    private var thumb: UIImageView!
    
    private var trackBackground:UIImageView!
    
    private var track: UIImageView!
    
    private var sectionLength: CGFloat = 0.0

    lazy var progressLayer: CAShapeLayer = {
        
        let layer = CAShapeLayer(layer: self.track.layer)
        layer.speed = 5;
        layer.strokeColor = UIColor.red.cgColor
        layer.lineJoin = kCALineJoinRound;
        layer.lineCap = kCALineCapRound;
        layer.strokeStart = 0.0;
        layer.lineWidth = self.track.frame.height
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: self.track.bounds.height / 2.0))
        bezierPath.addLine(to: CGPoint(x: self.track.frame.size.width, y: self.track.bounds.height / 2.0))
        layer.path = bezierPath.cgPath
        return layer
    }()
    
     var selectValue: valueBlock?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 */
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let image = UIImageView(image: minTrack)
        image.sizeToFit()
        let scale = (rect.size.width - 22) / image.frame.width
        // 图片不存在情况
        
        thumb = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 22, height: 22))
        thumb.backgroundColor = thumbBackgroundColor
        thumb.layer.cornerRadius = 11
        thumb.image = thumbOn
        
        trackBackground = UIImageView(frame: CGRect(x: 11, y: 0.0, width: rect.size.width - 22, height: 7 * scale))
        trackBackground.backgroundColor = minTrackBackgroundColor
        trackBackground.center.y = thumb.center.y
        trackBackground.layer.cornerRadius = trackBackground.frame.height / 2.0
        trackBackground.image = minTrack
        
        track = UIImageView(frame: trackBackground.frame)
        track.image = maxTrack
        track.layer.cornerRadius = trackBackground.frame.height / 2.0
        track.backgroundColor = maxTrackBackgroundColor
        self.addSubview(trackBackground)
        self.addSubview(track)
        self.addSubview(thumb)
        
        let maskLayer = CALayer(layer: track.layer)
        maskLayer.addSublayer(self.progressLayer)
        track.layer.mask = maskLayer
        
        if !titleHidden {
            addSliderTitles()
        }else{
            sectionLength = track.frame.width / CGFloat(count - 1)
        }
        selectSectionIndex(current, true)
    }

    func addSliderTitles() {
        
        if titles == nil {
            titles = []
            for index in 0 ... count{
                titles?.append("\(index)")
            }
        }else{
            count = titles!.count
        }
        sectionLength = track.frame.width / CGFloat(count - 1)
        let titleWidth = titles?.reduce(0.0) { (sum, string) -> CGFloat in
            let sumLabel = UILabel()
            sumLabel.font = .systemFont(ofSize: 11.0)
            sumLabel.text = string
            sumLabel.sizeToFit()
            return sum + sumLabel.frame.width
        }
        let space = (self.frame.width - titleWidth! - trackBackground.frame.height) / CGFloat(count - 1)
        var originX: CGFloat = trackBackground.frame.height / 2.0
        for index in 0 ..< count  {
            let label = UILabel()
            label.font = .systemFont(ofSize: 11.0)
            label.textColor = titleColor
            label.text = titles?[index]
            label.sizeToFit()
            label.frame = CGRect(x: originX, y: self.bounds.height - label.frame.height - 8, width: label.frame.width, height: label.frame.height)
            originX += label.frame.width + space
            self.addSubview(label)
        }
    }
    
    func selectSectionIndex(_ index: Int, _ animated: Bool) {
        
        let  p = CGFloat(index) / CGFloat(count - 1)
        if (animated)
        {
            var thumbCenter = thumb.center
            thumbCenter.x = track.frame.origin.x + sectionLength * CGFloat(current)
            
            if index == 0{
                thumbCenter.x += track.frame.height / 2.0
            }else if index == count - 1{
                thumbCenter.x -= track.frame.height / 2.0
            }
            CATransaction.begin()
            CATransaction.setDisableActions(false)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
            CATransaction.setAnimationDuration(0.25)
            progressLayer.strokeEnd = p;
            thumb.center = thumbCenter
            CATransaction.commit()
        } else
        {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
            CATransaction.setAnimationDuration(0.25)
            progressLayer.strokeEnd = p;
            CATransaction.commit()
        }
    }
    
    func moveSlideView(_ touch: UITouch)  {
        
        var point = touch.location(in: self)
        if point.x <= (track.frame.origin.x + track.frame.height / 2.0){
            
            point.x = (track.frame.origin.x + track.frame.height / 2.0)
            
        }else if(point.x >= track.frame.origin.x + track.frame.width - track.frame.height){
            point.x = track.frame.origin.x + track.frame.width - track.frame.height
        }
        let p: CGFloat = ( point.x - track.frame.origin.x ) / track.frame.width
        
        var thumbCenter = thumb.center;
        thumbCenter.x = point.x;
        
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        CATransaction.setAnimationDuration(0.25)
        progressLayer.strokeEnd = p;
        thumb.center = thumbCenter
        CATransaction.commit()
    }
    
    func checkPointX(_ touch: UITouch) {
        
        var point = touch.location(in: self)
        if point.x < 0 {
            point.x = track.frame.origin.x
        }else if(point.x > self.track.frame.origin.x + track.frame.width){
            point.x = self.track.frame.origin.x + track.frame.width
        }
        let index = Int(roundf(Float((point.x - track.frame.origin.x ) / CGFloat(sectionLength))))
        
        guard index != current else {
            selectSectionIndex(index, true)
            return
        }
        current = index
        selectSectionIndex(current, true)
        self.selectValue?(index)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        moveSlideView(touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        moveSlideView(touch)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        checkPointX(touch!)
        self.layoutIfNeeded()
    }
}
