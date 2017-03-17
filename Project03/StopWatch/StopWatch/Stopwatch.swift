//
//  Stopwatch.swift
//  StopWatch
//
//  Created by Karl on 2017/3/17.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
    
}
