//
//  MasterViewController.swift
//  CandySearch
//
//  Created by Karl on 2017/3/22.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    //MARK: - properties
    var detailViewController: DetailViewController? = nil
    var candies = [Candy]()
    var filterCandies = [Candy]()
    let searchController = UISearchController.init(searchResultsController: nil)

    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        setupSearchController()
        candies = [
            Candy(category:"Chocolate", name:"Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark Chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy Cane"),
            Candy(category:"Hard", name:"Jaw Breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour Chew"),
            Candy(category:"Other", name:"Gummi Bear")
        ]
        
        if let splitViewcontroller = splitViewController {
            let controllers = splitViewcontroller.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }
        
    }
    
    //MARK: - Search controller setup
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        mainTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All","Chocolate","Hard","Other"]
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filterCandies = candies.filter{ candy in
            let categoryMatch = (scope == "All") || (candy.category == scope)
            return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
        }
        mainTableView.reloadData()
    }
    
    //MARK: - tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  searchController.isActive && searchController.searchBar.text != "" {
            return filterCandies.count
        }
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let candy: Candy
        if searchController.isActive && searchController.searchBar.text != "" {
            candy = filterCandies[indexPath.row]
        }else{
            candy = candies[indexPath.row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category
        return cell
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = mainTableView.indexPathForSelectedRow {
            let candy: Candy
            if searchController.isActive && searchController.searchBar.text != "" {
                candy = filterCandies[indexPath.row]
            } else {
                candy = candies[indexPath.row]
            }
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailCandy = candy
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}

extension MasterViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension MasterViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
