//
//  TBToiletViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/11/17.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit
class TBToiletViewController: UIViewController {
    
    
    @IBOutlet weak var sliderView: ZYSlideView!
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
    }
    
    @IBAction func normalCleanAction(_ sender: UIButton){
        
        let normalClean = TBNormalCleanView.shareNormalCleanView()
        normalClean.showIn(view: self.view, data: (2, 1, 1, 2))
    }
    
    @IBAction func femaleCleanAction(_ sender: UIButton){
        let normalClean = TBNormalCleanView.shareFemaleCleanView()
        normalClean.showIn(view: self.view, data: (1, 3, 2, 1))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
