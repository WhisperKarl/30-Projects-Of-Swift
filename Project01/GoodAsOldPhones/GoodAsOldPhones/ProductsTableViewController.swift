//
//  ProductsTableViewController.swift
//  GoodAsOldPhones
//
//  Created by Karl on 2017/3/15.
//  Copyright © 2017年 whisperkarl.com. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        products = [Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
                    Product(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
                    Product(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
                    Product(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")]
        
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
        if let products = products {
            return products.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "productCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = products?[(indexPath as NSIndexPath).row].name
        
        if let imageName = products?[(indexPath as NSIndexPath).row].cellImageName {
            cell.imageView?.image = UIImage(named: imageName)
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

   //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct"{
            let productVC = segue.destination as? ProductViewController
            
            if let cell = sender as? UITableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    productVC?.product = products?[indexPath.row]
                }
            }
        }
    }
    

}
