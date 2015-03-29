//
//  Event.swift
//  tada
//
//  Created by Ray on 15/1/24.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import Foundation
import EventKit
import UIKit

var appDelegate:AppDelegate?

var isAccessToEventStoreGranted:Bool = true
var startDate=NSDate().dateByAddingTimeInterval(-60*60*24)
var endDate=NSDate().dateByAddingTimeInterval(60*60*24*30)
var status = false
var firstTime:String = ""
func getFirstTime()->String{
    if appDelegate!.events.isEmpty{
        let a = (appDelegate!.events[0] as EKReminder).startDateComponents.hour
        var hour = String(a)
        
        let b = (appDelegate!.events[0] as EKReminder).startDateComponents.minute
        var minute = String(b)
        if minute.hasSuffix("0") {
            minute += "0"
        }
        firstTime = hour+":"+minute
    }
    return firstTime
}


func accessEventStore() {
    appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    println("access 1")
    if appDelegate!.eventStore == nil {
        println("access 2")
        appDelegate!.eventStore = EKEventStore()
        println("access 3")
        appDelegate!.eventStore!.requestAccessToEntityType(EKEntityTypeReminder, completion: {(granted,error) in
            if !granted {
                println("access 4")
                println("Access to store not granted")
                println(error.localizedDescription)
                isAccessToEventStoreGranted = false
            } else {
                println("access 5")
                println("Access granted")
                isAccessToEventStoreGranted = true
            }
        })
    }
}

func loadReminders() {
    appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    appDelegate!.eventStore = EKEventStore()
    
    println("loadReminders   \(isAccessToEventStoreGranted)")
    
    if isAccessToEventStoreGranted {
        
        var calendars = appDelegate!.eventStore!.calendarsForEntityType(EKEntityTypeReminder)
        
        var predicate = appDelegate!.eventStore!.predicateForRemindersInCalendars([])
        
        appDelegate!.eventStore!.fetchRemindersMatchingPredicate(predicate) { reminders in
            for reminder:EKReminder in reminders as [EKReminder] {
                
                if reminder.creationDate!.compare(startDate) == .OrderedDescending && reminder.completed == false{
                    
                    appDelegate!.events.append(reminder)
                    println(reminder.title)
                    println(reminder.completed)
                    println(reminder.calendarItemIdentifier)
                    /*
                    println(appDelegate!.events.count)
                    println(reminder.startDateComponents)
                    println(reminder.dueDateComponents)
                    println(reminder.alarms.description)
*/
                    status = false
                    
                }
            }
            
            println("load completed")
            calSort()
        }
        
        
    }
}

func createReminder() {
    appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    let reminder = EKReminder(eventStore: appDelegate!.eventStore)
    let now = NSDate()
    
    let cal = appDelegate!.eventStore!.calendarsForEntityType(EKEntityTypeReminder)
    
    reminder.title = reminderText
    reminder.calendar = appDelegate!.eventStore!.defaultCalendarForNewReminders()
    /*
    var todayComponents = NSDateComponents()
    
    todayComponents.year = 2015
    todayComponents.month = 1
    todayComponents.day = 28
    todayComponents.hour = 16
    */
    //let todayDate = NSCalendar.currentCalendar().dateFromComponents(todayComponents)
    //Reminders新建的提醒事项默认是没有startDateComponents和due这两个属性的 如果有闹钟的话 会新建startDateComponents和dueDate和alarm
    
    reminder.startDateComponents = reminderTimeComponent
    
    reminder.dueDateComponents = reminderTimeComponent
    
    let todayDate:NSDate = NSCalendar.currentCalendar().dateFromComponents(reminderTimeComponent!)!
    //就是看提醒时间
    
    if setAlarm {
        reminder.addAlarm(EKAlarm(absoluteDate: todayDate))
    }
    
    
    var error:NSError?
    appDelegate!.eventStore!.saveReminder(reminder, commit:true, error: &error)
    
    refreshEvents()
    
    while(!status) {
        
    }
    
    status = false
    
}

func calSort() {
    /*
    sort(&appDelegate!.events,{(a:EKReminder,b:EKReminder) -> Bool in
        
        let ad = NSCalendar.currentCalendar().dateFromComponents(a.startDateComponents)
        let bd = NSCalendar.currentCalendar().dateFromComponents(b.startDateComponents)
    
        if (ad!.compare(bd!)) == .OrderedAscending {
            return false
        } else {
            return true
        }
    })
    status = true
*/
    /*
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [unsortedArray sortedArrayUsingDescriptors:sortDescriptors];
*/
status = true
}

func refreshEvents() -> Bool{
    status = false
    
    appDelegate!.events.removeAll(keepCapacity: true)
    
    loadReminders()
    
    while(!status){
        
    }
    
    return true
}

























