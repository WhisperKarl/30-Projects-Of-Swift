//
//  WorkTableViewCell.swift
//  Artistry
//
//  Created by Karl on 2017/3/21.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {

    @IBOutlet weak var moreInfoTextView: UITextView!
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var workImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
