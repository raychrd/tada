//
//  FutureEventTableViewController.swift
//  tada
//
//  Created by Ray on 15/1/24.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import UIKit

class FutureEventTableViewController: UITableViewController {
    var attractionImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        attractionNames = ["Buckingham Palace",
            "The Eiffel Tower",
            "The Grade Canyon",
            "Windsor Castle",
            "Empire State Building"
        ]
        webAddresses = ["http://www.baidu.com",
            "http://en.wikipedia.org/wiki/Eiffel_Tower",
            "http://en.wikipedia.org/wiki/Grand_Canyon",
            "http://en.wikipedia.org/wiki/Windsor_Castle",
            "http://en.wikipedia.org/wiki/Empire_State_Building"
        ]
        attractionImages = ["buckingham_palace.jpg",
            "eiffel_tower.jpg",
            "grand_canyon.jpg",
            "windsor_castle.jpg",
            "empire_state_building.jpg"
        ]
        tableView.estimatedRowHeight = 50
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "showFutureEventDetails" {
            let detailViewController = segue.destinationViewController as FutureEventDetailViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow()
            let row = myIndexPath?.row
            println(row)
            detailViewController.eventDetail = webAddresses[row!] }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return attractionNames.count
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MKTableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("FutureEventTableCell", forIndexPath: indexPath) as MKTableViewCell
        let row = indexPath.row
        cell.a.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.a.text = attractionNames[row]
        // Configure the cell...
        
        return cell

    }
    
    */
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */


}
