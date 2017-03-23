//
//  DetailViewController.swift
//  CandySearch
//
//  Created by Karl on 2017/3/22.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    var detailCandy: Candy?
        
//        {
//        didSet {
//            configureView()
//        }
//    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            print(detailCandy.name)
            detailLabel.text = detailCandy.name
            detailImageView.image = UIImage.init(named: detailCandy.name)
            title = detailCandy.category
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
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
