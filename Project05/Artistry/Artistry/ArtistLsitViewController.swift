//
//  ArtistLsitViewController.swift
//  Artistry
//
//  Created by Karl on 2017/3/21.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class ArtistLsitViewController: UIViewController, UITableViewDataSource {
    
    let artists = Artist.artistsFromBundle()
    
    @IBOutlet weak var artistListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        artistListTableView.rowHeight = UITableViewAutomaticDimension
        artistListTableView.estimatedRowHeight = 140
        artistListTableView.dataSource = self
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.artistListTableView.reloadData()
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistDetailViewController,
            let IndexPath = artistListTableView.indexPathForSelectedRow {
            destination.selecteddArtist =  artists[IndexPath.row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistTableViewCell
        let artist = artists[indexPath.row]
        
        cell.bioLabel.text = artist.bio
        cell.bioLabel.textColor = UIColor.init(white: 114/255, alpha: 1)
        
        cell.artistImageView.image = artist.image
        cell.nameLabel.text = artist.name
        
        cell.nameLabel.backgroundColor = UIColor.init(red: 1, green: 152/255, blue: 0, alpha: 1)
        cell.nameLabel.textColor = UIColor.white
        cell.nameLabel.textAlignment = .center
        cell.selectionStyle = .none
        
        cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
        
    }

    
}

