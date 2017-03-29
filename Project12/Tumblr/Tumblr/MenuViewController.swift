//
//  MenuViewController.swift
//  Tumblr
//
//  Created by Karl on 2017/3/29.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var textImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var quoteImage: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var linkImage: UIImageView!
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatLabel: UILabel!
    
    @IBOutlet weak var audioImage: UIImageView!
    @IBOutlet weak var audioLabel: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBAction func cancelAction(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
