//
//  ICSlideView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/20.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit
@IBDesignable
class ZYSlideView: UIControl {
    @IBInspectable var image: UIImage?
    
    private var thumb: UIImageView!
    private var track: UIImageView!
    lazy var progressLayer: CAShapeLayer = {
        
        let layer = CAShapeLayer()
        layer.speed = 5;
        layer.frame = self.track.layer.bounds;
        layer.strokeColor = UIColor.red.cgColor
        layer.lineJoin = kCALineJoinRound;
        layer.lineCap = kCALineCapRound;
        layer.strokeStart = 0.0;
        return layer
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
 */
    override func draw(_ rect: CGRect) {
        // Drawing code
        thumb = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 30, height: 30))
//        track.frame = CGRect(x: thumb.frame.width / 2.0 - track.frame.height / 2.0, y: 0.0, width: self.bounds.width - thumb.frame.width + track.frame.height, height: track.frame.height)
        track = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width - 100, height: 30))
        track.image = image
//        self.addSubview(thumb)
        self.addSubview(track)
//        let bezierPath = UIBezierPath()
//        bezierPath.move(to: CGPoint(x: 0.0, y: track.frame.size.height / 2))
//        bezierPath.addLine(to: CGPoint(x: track.frame.size.width, y: track.frame.size.height / 2.0))
//        self.progressLayer.path = bezierPath.cgPath;
    }

}
