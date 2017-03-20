//
//  Utils.swift
//  Todo
//
//  Created by Karl on 2017/3/20.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}


