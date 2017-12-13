//
//  FlyBirdViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class FlyBirdViewController: UIViewController {

    @IBOutlet weak var singleButton: UIButton!
    @IBOutlet weak var limitButton: UIButton!
    @IBOutlet weak var longTimeButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    var viewcontrollers:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewcontrollers.append(segue.destination)
    }
    
    @IBAction func SelectControlMode(_ sender: UIButton) {
        selectMode(sender.tag)
        
        mainScrollView.setContentOffset(CGPoint(x: CGFloat(sender.tag) * self.view.frame.width, y: 0), animated: true)
    }
}

extension FlyBirdViewController: UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.width
        selectMode(NSInteger(index))
    }
    
    func selectMode(_ mode: NSInteger) {
        
        singleButton.isSelected = false
        limitButton.isSelected = false
        longTimeButton.isSelected = false
        if mode == 0 {
            singleButton.isSelected = true
        }else if mode == 1 {
            limitButton.isSelected = true
        }else{
            longTimeButton.isSelected = true
        }
        viewcontrollers[mode].beginAppearanceTransition(true, animated: true)
        viewcontrollers[mode].endAppearanceTransition()
       
    }
}
