//
//  NewsTableViewController.swift
//  SimpleRSSReader
//
//  Created by Karl on 2017/3/23.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    fileprivate let feedParser = FeedParser()
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    
    fileprivate var rssItems: [(title: String, description: String, pubDate: String)]?
    fileprivate var cellStates: [CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .singleLine
        
        feedParser.parseFeed(feedURL: feedURL) {
            [weak self] rssItems in
            self?.rssItems = rssItems
            self?.cellStates = Array.init(repeating: .collapsed, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet.init(integer: 0), with: .none)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        if let item  = rssItems?[indexPath.row] {
            (cell.titleLabel.text, cell.descriptionLabel.text, cell.dateLabel.text) = (item.title, item.description, item.pubDate)
            if let cellStet = cellStates?[indexPath.row] {
                cell.descriptionLabel.numberOfLines = cellStet == CellState.expanded ? 0 : 4
            }
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = cell.descriptionLabel.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell.descriptionLabel.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
        
    }

}
