//
//  Products.swift
//  GoodAsOldPhones
//
//  Created by Karl on 2017/3/15.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import Foundation
class Product {
    var name: String?
    var cellImageName: String?
    var fullscreenImageName: String?
    
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName
    }
}
