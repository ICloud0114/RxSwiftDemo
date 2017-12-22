//
//  FlyBirdViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

let filePath = NSHomeDirectory() + "/Documents/users.plist"

class FlyBirdViewController: UIViewController {

    @IBOutlet weak var singleButton: UIButton!
    @IBOutlet weak var limitButton: UIButton!
    @IBOutlet weak var longTimeButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
//    var socket: GCDAsyncSocket?
    var longTimer: Timer?
    var viewcontrollers:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let saveItem = UIBarButtonItem(title: "历史", style: .plain, target: self, action: #selector(pushToHistoryList))
        navigationItem.rightBarButtonItem = saveItem
        
        // Do any additional setup after loading the view.
//        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
//
//        do {
//            let _ = try socket?.connect(toHost: "121.15.200.120", onPort: 5577)
////            longTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(longConnectToSocket), userInfo: nil, repeats: true)
////            RunLoop.current.add(longTimer!, forMode: .commonModes)
//        } catch (_) {
////            rxFatalError("RefCountDisposable decrement on release failed")
//        }
//
//        guard let _ = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) else {
//            let array:[[String]] = []
//            NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
//            return
//        }
//
//        NSKeyedArchiver.archiveRootObject([], toFile: filePath)
    }
    
//    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
//
//        sock.write("FNLinktest".data(using: .utf8)!, withTimeout: -1, tag: 0)
//        socket?.readData(withTimeout: -1, tag: 0)
//    }
//
//    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
//
//        let message = String(bytes: data, encoding: .utf8)
////        let message = "FNText_456789_Open_201711150927"
//        print("receive message:" + message!)
//        if  message!.hasPrefix("FNText"){
//
//            let subMessage: [String] = message!.components(separatedBy: "FNText").filter({$0.count > 0})
//            let result = subMessage.map({$0.components(separatedBy: "_").filter({$0.count > 0})
//            })
//
//            guard var history = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [[String]] else {
//                return
//            }
//
//            history.append(contentsOf: result)
//
//            NSKeyedArchiver.archiveRootObject(history, toFile: filePath)
//        }
//        socket?.readData(withTimeout: -1, tag: 0)
//    }
//
//    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
//
//        print("tcp disconnect")
//        socket?.write("FNLinktest".data(using: .utf8)!, withTimeout: -1, tag: 0)
//    }
//
//    @objc func longConnectToSocket(){
//
//        socket?.write("FNLinktest".data(using: .utf8)!, withTimeout: -1, tag: 0)
//
//    }
    @objc func pushToHistoryList(){
        let storyboard = UIStoryboard(name: "HistoryList", bundle: nil)
        
        let setting: HistoryListViewController = storyboard.instantiateViewController(withIdentifier: "HistoryListViewController") as! HistoryListViewController
        
        self.navigationController?.pushViewController(setting, animated: true)
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
