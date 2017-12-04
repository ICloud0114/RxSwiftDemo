//
//  ToiletControlView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/17.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ToiletControlView: UIView {

    @IBOutlet weak var buttocksBtn: UIButton!
    @IBOutlet weak var femaleCleanBtn: UIButton!
    @IBOutlet weak var dryBtn: UIButton!
    @IBOutlet weak var flushBtn: UIButton!
    @IBOutlet weak var childBtn: UIButton!
    @IBOutlet weak var maleAutoBtn: UIButton!
    @IBOutlet weak var femaleAutoBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
//        let username: Observable<Bool>
//        username.flatMapLatest { result in
//            return true
//        }.shareReplay(1)
//      let _ =  username.bind(to: buttocksBtn.rx.isSelected).addDisposableTo(DisposeBag())
        
        
    }
   
}
