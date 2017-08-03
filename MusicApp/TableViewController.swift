//
//  TableViewController.swift
//  MusicApp
//
//  Created by VuHongSon on 8/1/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var listName:[String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(1)
        let queue = DispatchQueue(label: "queue")
        queue.async {
            let url:NSURL = NSURL(string: "http://sonvuhong.com/list.php?cot=Name")!
            do {
                let ds:NSString = try NSString(contentsOf: url as URL, encoding: String.Encoding.utf8.rawValue)
                self.listName = ds.components(separatedBy: "#") as [String]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch {
                print("Load Error")
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if listName == nil {
            return 1
        }
        return listName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if listName == nil {
            cell.textLabel?.text = "Loading..."
        }else {
            cell.textLabel?.text = listName[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detaiView = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        detaiView.index = indexPath.row
        detaiView.name = listName[indexPath.row]
        present(detaiView, animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
