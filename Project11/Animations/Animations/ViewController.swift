//
//  ViewController.swift
//  Animations
//
//  Created by Karl on 2017/3/28.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

let duration = 1.5
let segueIdentifier = "showDetail"
let headerHeight = 50.0

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position","Color and Frame Change", "View Fade In", "Pop"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    //MARK: - cell animation
    func animateTable() {
        mainTableView.reloadData()
        
        let cells = mainTableView.visibleCells
        let tableHeight = mainTableView.bounds.size.height
        
        //把所有cell移出屏幕
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        //把所有cell放回原位置
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: duration, delay: 0.05*Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: { 
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let detailView = segue.destination as! DetailViewController
            let indexPath = mainTableView.indexPathForSelectedRow
            
            if let indexPath = indexPath {
                detailView.barTitle = items[indexPath.row]
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
}
//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

