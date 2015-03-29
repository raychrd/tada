//
//  ListTableViewController.swift
//  tada
//
//  Created by Ray on 15/1/26.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import UIKit
import EventKit

class ListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var labels = ["MKButton", "MKTextField", "MKTableViewCell", "MKTextView", "MKColor", "MKLayer", "MKAlert", "MKCheckBox"]
    var rippleLocations: [MKRippleLocation] = [.TapLocation, .TapLocation, .Center, .Left, .Right, .TapLocation, .TapLocation, .TapLocation]
    var circleColors = [UIColor.MKColor.LightBlue, UIColor.MKColor.Grey, UIColor.MKColor.LightGreen]
    
    override func viewDidLoad() {
        /*
        refreshEvents()
        
        while(!status) {
            
        }
        
        status = false
        */
        self.navigationController?.interactivePopGestureRecognizer.delegate = nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("tableView \(appDelegate!.events.count)")

        return appDelegate!.events.count
        //return 100
    }
    /*
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    */
    
    
    //@IBOutlet weak var topView: UIView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as MyCell
        cell.setMessage(appDelegate!.events[indexPath.row].title)
        
        /*
        if appDelegate!.events[indexPath.row].startDateComponents != nil {
            
            let a = (appDelegate!.events[indexPath.row]).startDateComponents.hour
            var hour = String(a)
            
            let b = (appDelegate!.events[indexPath.row]).startDateComponents.minute
            var minute = String(b)
            
            if minute.hasPrefix("0") {
                minute += "0"
            }
            let timeText = ""+hour+":"+minute
            
            cell.setTime(timeText)
        } else {
            cell.setTime("88")
        }
*/
       // cell.rippleLocation = rippleLocations[indexPath.row]
        /*
        UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 8)];
        separatorLineView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:separatorLineView];
        */
        /*
        var separatorLineView:UIView = UIView(frame: CGRectMake(0, 0, 400, 10))
        separatorLineView.backgroundColor = UIColor.whiteColor()
        cell.contentView.addSubview(separatorLineView)
        */
        
        
        let index = indexPath.row % circleColors.count
        cell.circleLayerColor = circleColors[index]
        
        return cell
    }
    /*
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var deleteAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {
            (action:UITableViewRowAction!,indexPath:NSIndexPath!) -> Void in
            println("delete button pressed")
        })
        
        
        tableView.reloadData()
    }
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            //self.deleteItem(mutableItemList[indexPath.row])
            // show fancy fade animation to remove the cell from the table view
            //appDelegate!.events[indexPath.row].
            println(appDelegate!.events[indexPath.row].calendarItemIdentifier)
            
            /*
            
            */
            let index = indexPath.row
            
            let a = appDelegate!.eventStore!.calendarItemWithIdentifier(appDelegate!.events[indexPath.row].calendarItemIdentifier) as EKReminder
            var error:NSError?
            
            appDelegate?.eventStore?.removeReminder(a, commit: true, error: &error)
            /*
            appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
            let a = appDelegate!.eventStore!.calendarItemWithIdentifier(appDelegate!.events[index].calendarItemIdentifier) as EKReminder
            
            
            */
            appDelegate!.events.removeAtIndex(index)
            
            tableView.reloadData()
            
            let bbb = refreshEvents()
            
            
        }
    }
    
}
