//
//  NewEventViewController.swift
//  tada
//
//  Created by Ray on 15/1/27.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {
    
    var returnPressed:Bool = false
    @IBOutlet var textField: MKTextField!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var reminderTitle: UILabel!
    @IBAction func textFieldReturn(sender: AnyObject) {
        analyseString(textField.text)
        reminderTitle.text = reminderText
        let currentDate = NSCalendar.currentCalendar().dateFromComponents(reminderTimeComponent!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        let timeString = dateFormatter.stringFromDate(currentDate!)
        
        if setAlarm {
            time.text = "提醒时间 "+timeString
        } else {
            time.text = "未指定具体时间"
        }
        returnPressed = true
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.borderColor = UIColor.clearColor().CGColor
        textField.floatingPlaceholderEnabled = true
        textField.placeholder = "New Reminder"
        textField.tintColor = UIColor.MKColor.moreGreen
        textField.rippleLocation = .Right
        textField.cornerRadius = 0
        textField.bottomBorderEnabled = true
        
        newButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        self.navigationController?.interactivePopGestureRecognizer.delegate = nil
        
        textField.becomeFirstResponder();
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) { textField.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func add(sender: AnyObject) {
        if returnPressed {
           createReminder()
        } else {
            analyseString(textField.text)
            
            reminderTitle.text = reminderText
            let currentDate = NSCalendar.currentCalendar().dateFromComponents(reminderTimeComponent!)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd HH:mm"
            let timeString = dateFormatter.stringFromDate(currentDate!)
            
            if setAlarm {
                time.text = "提醒时间 "+timeString
            } else {
                time.text = "未指定具体时间"
            }
            
            createReminder()
            
            returnPressed = false
        }
        
        let bbb = refreshEvents()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
