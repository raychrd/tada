//
//  ViewController.swift
//  tada
//
//  Created by Ray on 15/1/24.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import UIKit
import EventKit
import LTMorphingLabel


class ViewController: UIViewController,CNPPopupControllerDelegate{

    
    @IBOutlet weak var nextToDo: UILabel!
    @IBOutlet weak var firstEvent: UILabel!
    @IBOutlet weak var firstEventTime: UILabel!
    @IBOutlet weak var test: UIButton!
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var moreThan: UILabel!
    
    
    var c:CNPPopupController = CNPPopupController()
    
    
    
    var authorizationStatus:EKAuthorizationStatus = EKEventStore.authorizationStatusForEntityType(EKEntityTypeReminder)
    
    //var appDelegate:AppDelegate?
    
    var notificationContent:String = ""
    var a = 1;
    var b = 1;

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        authorizationStatus = EKEventStore.authorizationStatusForEntityType(EKEntityTypeReminder)
        println(EKEventStore.authorizationStatusForEntityType(EKEntityTypeReminder) == .Authorized)
        
        if (authorizationStatus == .NotDetermined) {
            showPopupWithStyle(CNPPopupStyle.Centered)
            println("virgn")
            authorizationStatus = EKEventStore.authorizationStatusForEntityType(EKEntityTypeReminder)
        }
        
        
        //self.navigationController?.interactivePopGestureRecognizer.delegate = nil
        
        if authorizationStatus == .Authorized {
            println("view Did appear \(status)")
            
            
            println(appDelegate!.events.count)
            nextToDo.text = "Next to do"
            //status = false
            let bbb = refreshEvents()
            
            updateFirstEvent()
            status = false
            
            
        }
        
        test.layer.cornerRadius = 20
        
        
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if ((self.navigationController?.respondsToSelector("interactivePopGestureRecognizer")) != nil) {
            self.navigationController?.interactivePopGestureRecognizer.enabled = false
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "storeChanged:", name: "EKEventStoreChangedNotification", object: appDelegate!.eventStore)
        println("Notification 1")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reActived:", name: "UIApplicationWillEnterForegroundNotification", object: nil)
        println("Notification 2")
        
        updateFirstEvent()
       
        
    }
    
    
    
    
    override func viewWillDisappear(animated: Bool) {
        println("remove observer")
        NSNotificationCenter.defaultCenter().removeObserver(self)
        if ((self.navigationController?.respondsToSelector("interactivePopGestureRecognizer")) != nil) {
            self.navigationController?.interactivePopGestureRecognizer.enabled = true
            self.navigationController?.interactivePopGestureRecognizer.delegate = nil
        }
    }
    
    
    

    

    @IBAction func changeText(sender: AnyObject) {
        let a = appDelegate!.eventStore!.calendarItemWithIdentifier(appDelegate!.events[0].calendarItemIdentifier) as EKReminder
        a.completed = true
        var error:NSError?
        appDelegate!.eventStore!.saveReminder(a, commit: true, error: &error)
        appDelegate!.events.removeAtIndex(0)
        numbers.text = String(appDelegate!.events.count)
        let bbb = refreshEvents()
        if bbb {
            status = false
        }
        updateFirstEvent()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func storeChanged(title:NSNotification){
        /*
        var c = title.description
        //var b = notificationContent
        
        if((title.userInfo?.description) != notificationContent) {
            println(a)
            let now = NSDate()
            println(now)
            notificationContent = title.userInfo!.description
            println(title.description)
            println(title.userInfo?.description)
        }
        a++
        
        refreshEvents()
        
        
        while(!status) {
        }
        
        updateFirstEvent()

       */
    }
    
    func reActived(notification:NSNotification) {
        
        println("reA")
        
        
        
        refreshEvents()
      
        while(!status) {
        }
        
        updateFirstEvent()
        
    }
    
    func updateFirstEvent() {
        println("updateFirstEvent \(appDelegate!.events.count)")
        if appDelegate!.events.count > 0 {
            
            nextToDo.text = "Next to do"
            
            firstEvent.text = appDelegate!.events[0].title
            
            if ((appDelegate!.events[0] as EKReminder).startDateComponents != nil){
                
                let a = (appDelegate!.events[0] as EKReminder).startDateComponents.hour
                var hour = String(a)
                
                let b = (appDelegate!.events[0] as EKReminder).startDateComponents.minute
                var minute = String(b)
                if minute.hasPrefix("0") {
                    minute += "0"
                }
                firstTime = "at "+hour+":"+minute
                firstEventTime.text = firstTime
            }
            
        } else {
            nextToDo.text = "Nothing to do"
            firstEvent.text = "Everything was done!"
            
            firstEventTime.text = ""
        }
        if appDelegate!.events.count > 9 {
            numbers.text = "9"
            moreThan.text = "+"
        } else {
            numbers.text = String(appDelegate!.events.count)
            moreThan.text = ""
        }
    }
    
    
   
    func showPopupWithStyle(popupStyle:CNPPopupStyle) {
        var paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraphStyle.alignment = NSTextAlignment.Center
        
        var title:NSAttributedString = NSAttributedString(string: "获取权限", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(24),NSParagraphStyleAttributeName:paragraphStyle])
        
        var lineOne:NSAttributedString = NSAttributedString(string: "为了为您提供服务，XXX需要访问“提醒事项的”的权限", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18),NSParagraphStyleAttributeName:paragraphStyle])
        
        let icon:UIImage = UIImage(named: "icon")!
        
        var line2:NSAttributedString = NSAttributedString(string: "请点击获取权限并确认", attributes: [NSFontAttributeName:UIFont.systemFontOfSize(18),NSForegroundColorAttributeName:UIColor(red: 0.46, green: 0.8, blue: 1.0, alpha: 1.0),NSParagraphStyleAttributeName:paragraphStyle])
        
        var buttonTitle:NSAttributedString = NSAttributedString(string: "获取权限", attributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(18),NSForegroundColorAttributeName:UIColor.whiteColor(),NSParagraphStyleAttributeName:paragraphStyle])
        
        var buttonItem:CNPPopupButtonItem = CNPPopupButtonItem()
        buttonItem.buttonTitle = buttonTitle
        buttonItem.backgroundColor = (UIColor(red: 0.46, green: 0.8, blue: 1.0, alpha: 1.0))
        buttonItem.cornerRadius = 3
        buttonItem.buttonHeight = 50
        buttonItem.selectionHandler = {item in
            
            accessEventStore()
            
            while (self.authorizationStatus != .Authorized ){
                self.authorizationStatus = EKEventStore.authorizationStatusForEntityType(EKEntityTypeReminder)
            }
            
            if self.authorizationStatus == .Authorized {
                
                println("pop \(status)")
                
                refreshEvents()
                
                //println(appDelegate!.events.count)
                
                self.nextToDo.text = "Next to do"
                
                //status = false
                
                while(!status) {
                    
                }
                
                self.updateFirstEvent()
                
                status = false
                
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "storeChanged:", name: "EKEventStoreChangedNotification", object: appDelegate!.eventStore)
                
                println("Notification 1")
                
                
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "reActived:", name: "UIApplicationWillEnterForegroundNotification", object: nil)
                
                println("Notification 2")
                
            }
            
            
        }
        
        c = CNPPopupController(title: title, contents: [lineOne,icon,line2], buttonItems: [buttonItem], destructiveButtonItem: nil)
        c.theme = CNPPopupTheme.defaultTheme()
        c.theme.popupStyle = popupStyle
        c.delegate = self
        self.c.theme.presentationStyle = CNPPopupPresentationStyle.SlideInFromBottom
        self.c.presentPopupControllerAnimated(true)
        
    }
    
    
    func popupControllerDidPresent(controller:CNPPopupController){
        println("presented")
    }


}
