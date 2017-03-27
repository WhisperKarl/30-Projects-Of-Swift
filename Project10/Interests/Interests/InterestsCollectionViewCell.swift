//
//  InterestsCollectionViewCell.swift
//  Interests
//
//  Created by Karl on 2017/3/27.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class InterestsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var interest: Interest! {
        didSet{
            configureUI()
        }
    }
    
    fileprivate func configureUI() {
        titleLabel.text = interest.title
        featuredImageView.image = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}
