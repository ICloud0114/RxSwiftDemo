//
//  TBToiletViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/17.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class TBToiletViewController: UIViewController {
    
    @IBOutlet weak var displayView: ToiletDisplayView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        sliderView.titles = ["1min","2min","3min","4min"]
//        sliderView.selectValue = {
//            value in
//            print("select \(value)")
//        }
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func normalCleanAction(_ sender: UIButton){
        
        let normalClean = TBNormalCleanView.shareNormalCleanView()
        normalClean.showIn(view: self.view, data: (2, 1, 1, 2))
        displayView.showProgressView(progress: 0.3, type: .normalClean)
    }
    
    @IBAction func femaleCleanAction(_ sender: UIButton){
        let normalClean = TBNormalCleanView.shareFemaleCleanView()
        normalClean.showIn(view: self.view, data: (1, 3, 2, 1))
        displayView.showProgressView(progress: 0.3, type: .femaleClean)
    }
    
    @IBAction func dryAction(_ sender: Any) {
        
        let dryView = TBDryView.shareDryView()
        dryView.showIn(view: self.view, level: 1)
        dryView.levelBlock = {
            level in
            print("\(level)")
        }
        dryView.complete = {
            print("dry view dismiss")
        }
        displayView.showProgressView(progress: 0.3, type: .dry)
    }

    @IBAction func flushAction(_ sender: UIButton) {

       _ = sender.startRepeatRotate(timeInterval: 3.0)
    }
    
    @IBAction func childCleanAction(_ sender: UIButton) {
        displayView.showProgressView(progress: 0.5, type: .childClean)
    }
    
    @IBAction func maleAutoCleanAction(_ sender: UIButton) {
        displayView.showProgressView(progress: 0.6, type: .maleAuto)
    }
    
    @IBAction func femaleAutoCleanAction(_ sender: UIButton) {
        displayView.showProgressView(progress: 0.7, type: .femaleAuto)
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        
        displayView.showProgressView(progress: 0.4, type: .stop)
    }
    
}
