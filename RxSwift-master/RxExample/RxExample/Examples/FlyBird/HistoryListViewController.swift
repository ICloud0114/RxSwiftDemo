//
//  HistoryListViewController.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/15.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController {

    var dataList:[Any] = []
    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let history = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Any] else {
            let array:[[String]] = []
            NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
            return
        }
        dataList = history
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryListCell = tableView.dequeueReusableCell(withIdentifier: "HistoryListCellIdentifier", for: indexPath) as! HistoryListCell
        
        let message = dataList[indexPath.row] as! [String]
        
        cell.password.text = message[0]
        cell.resultLabel.text = message[1]
        cell.dateLabel.text = message[2]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
