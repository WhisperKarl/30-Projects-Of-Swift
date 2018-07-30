//
//  MainViewController.swift
//  Tumblr
//
//  Created by Karl on 2017/3/29.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainViewController(_ sender: UIStoryboardSegue) {

        // Use data from the view controller which initiated the unwind segue
        dismiss(animated: true, completion: nil)
    }
    


    
}
