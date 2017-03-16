//
//  ViewController.swift
//  LoveTweet
//
//  Created by Karl on 2017/3/16.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var straightSwitch: UISwitch!
    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var workTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var genderSeg: UISegmentedControl!
    
    @IBOutlet weak var salaryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salaryAction(_ sender: Any) {
        let slider = sender as! UISlider
        let i = Int(slider.value)
        salaryLabel.text = "$\(i)k"
    }
    
    
    @IBAction func tweetBtnAction(_ sender: Any) {
        if (nameTextField.text == "" || workTextField.text == "" || salaryLabel.text == "") {
            showAlert("Info Miss", message: "Please fill out the form", buttonTtitle: "OK")
            return
        }
        let name: String! = nameTextField.text
        let work: String! = workTextField.text
        let salary: String! = salaryLabel.text
        
        let gregorian = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let components = (gregorian as NSCalendar?)?.components(NSCalendar.Unit.year, from: birthdayPicker.date, to: now, options: [])
        let age: Int! = components?.year
        
        var interestedIn: String! = "Women"
        if genderSeg.selectedSegmentIndex == 0 && !straightSwitch.isOn {
            interestedIn = "Men"
        }
        if (genderSeg.selectedSegmentIndex == 1 && straightSwitch.isOn) {
            interestedIn = "Women"
        }
        let message = "Hi, I am \(name!). As a \(age!)-year-old \(work!) earning \(salary!)/year, I am interested in \(interestedIn!). Feel free to contact me!"
        tweetSLCVC(message)
        
    }
    
    //fileprivate 字段的含义是文件内私有，而private是真正的私有，离开了作用域就不可用
    fileprivate func tweetSLCVC(_ tweet: String){
        if  SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo) {
            let weiboController: SLComposeViewController = SLComposeViewController.init(forServiceType: SLServiceTypeSinaWeibo)
            weiboController.setInitialText(tweet)
            self.present(weiboController, animated: true, completion: nil)
        } else {
            showAlert("Weibo Unavailabel", message: "Please configure your weibo account on decice" , buttonTtitle: "OK")
        }
    }
    
    fileprivate func showAlert(_ title: String, message: String, buttonTtitle: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction.init(title: buttonTtitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


}

