//
//  ArtistDetailViewController.swift
//  Artistry
//
//  Created by Karl on 2017/3/21.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class ArtistDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var selecteddArtist: Artist!
    
    let moreInfoText = "Selected For More Info >"

    @IBOutlet weak var workTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = selecteddArtist.name
        
        workTableView.estimatedRowHeight = 300
        workTableView.rowHeight = UITableViewAutomaticDimension
        
        workTableView.delegate = self
        workTableView.dataSource = self
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: .main) { [weak self] _ in
            self?.workTableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else { return
        }
        
        var work = selecteddArtist.works[indexPath.row]
        
        work.isExpanded = !work.isExpanded
        selecteddArtist.works[indexPath.row] = work
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selecteddArtist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkTableViewCell
        let work = selecteddArtist.works[indexPath.row]
        
        cell.workTitleLabel.text = work.title
        cell.workImageView.image = work.image
        
        cell.selectionStyle = .none
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        
        
        cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        return cell
    }

}


