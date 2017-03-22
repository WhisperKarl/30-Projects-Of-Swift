//
//  Candy.swift
//  CandySearch
//
//  Created by Karl on 2017/3/22.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class Candy: NSObject {
    
    var category: String
    var name: String
    
    init(category: String, name: String) {
        self.category = category
        self.name = name
    }

}
