//
//  ViewController.swift
//  StopWatch
//
//  Created by Karl on 2017/3/17.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {
    fileprivate let mainStopwatch: Stopwatch = Stopwatch()
    fileprivate let lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    @IBOutlet weak var lapTableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    //MARK: 禁用横屏模式
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        initCircleButton(lapButton)
        initCircleButton(startButton)
        lapButton.isEnabled = false
        lapTableView.delegate = self
        lapTableView.dataSource = self
    }
    
    fileprivate func initCircleButton(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.width / 2
        button.backgroundColor = UIColor.white
    }
    
    fileprivate func changeButton(_ button: UIButton, title: String, titleColor: UIColor){
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(titleColor, for: UIControlState())
    }

    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        var minutes: String = "\(stopwatch.counter / 60)"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        var seconds: String = String.init(format: "%.02f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }

    func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    //#MARK: reset timer
    fileprivate func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapTableView.reloadData()
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    
    fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }

    @IBAction func lapResetTimer(_ sender: Any) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapButton, title: "Lap", titleColor: UIColor.lightGray)
            lapButton.isEnabled = false
        } else {
            if let timerlabelText = timerLabel.text {
                laps.append(timerlabelText)
            }
            lapTableView.reloadData()
            resetLapTimer()
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func playPauseTimer(_ sender: Any) {
        lapButton.isEnabled = true
        changeButton(lapButton, title: "Lap", titleColor: UIColor.black)
        if !isPlay {
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            
            //添加到commonMods 防止滑动时停止计时
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoopMode.commonModes)
            RunLoop.current.add(lapStopwatch.timer, forMode: .commonModes)
            
            isPlay = true
            changeButton(startButton, title: "Stop", titleColor: UIColor.red)
        } else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(startButton, title: "Start", titleColor: UIColor.green)
            changeButton(lapButton, title: "Reset", titleColor: UIColor.black)
        }
        
    }
    
}

//MARK: tableview datasourece
//extension 可以遵守协议，实现代理方法
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "lapCell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let labelNum = cell.viewWithTag(1111) as? UILabel {
            labelNum.text = "Lap \(laps.count - indexPath.row)"
        }
        if let labelTimer = cell.viewWithTag(2222) as? UILabel {
            labelTimer.text = laps[laps.count - indexPath.row - 1]
        }
        
        return cell
    }
    
}

fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
