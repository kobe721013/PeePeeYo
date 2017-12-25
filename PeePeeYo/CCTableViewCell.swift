//
//  CCTableViewCell.swift
//  PeePeeYo
//
//  Created by kobe on 2017/12/16.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit

class CCTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ccLabel: UILabel!
    @IBOutlet weak var bodyTemperatureLabel: UILabel!
    @IBOutlet weak var highPLabel: UILabel!
    @IBOutlet weak var lowPLabel: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var breatheLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
