//
//  Top100TableViewCell.swift
//  2048
//
//  Created by Pavel Koval on 8/17/18.
//  Copyright © 2018 Alkotsuki. All rights reserved.
//

import UIKit

class Top100TableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
