//
//  HistoryListCell.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/15.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

class HistoryListCell: UITableViewCell {

    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var password: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
