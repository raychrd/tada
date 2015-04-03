//
//  NewReminder.swift
//  tada
//
//  Created by Ray on 15/1/27.
//  Copyright (c) 2015年 Ray. All rights reserved.
//

import Foundation
import EventKit
import UIKit


class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
    }
    
    func re(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input)))
        return matches.count > 0
    }
}
var setAlarm:Bool = false
var reminderText:String?
var reminderTimeComponent:NSDateComponents?
let date:NSDate = NSDate()
//let flags: NSCalendarUnit = .DayCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit | .WeekdayCalendarUnit
let flags:NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute
let todayComponents = NSCalendar.currentCalendar().components(flags, fromDate: date)

let dayWords1 = ["今天","明天","后天"]

let dayWords2 = ["周一","周二","周三","周四","周五","周六","周日","周天","星期一","星期二","星期三","星期四","星期五","星期六","星期天"]

let dayWords3 = ["下周一","下周二","下周三","下周四","下周五","下周六","下周日","下周天"]

let dayWords4 = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月月","十一月","十二月"]

let dayWords5 = ["一日","二日","三日","四日","五日","六日","七日","八日","九日","十日","十一日","十二日","十三日","十四日","十五日","十六日","十七日","十八日","十九日","二十日","二十一日","二十二日","二十三日","二十四日","二十五日","二十六日","二十七日","二十八日","二十九日","三十日","三十一日","一号","二号","三号","四号","五号","六号","七号","八号","九号","十号","十一号","十二号","十三号","十四号","十五号","十六号","十七号","十八号","十九号","二十号","二十一号","二十二号","二十三号","二十四号","二十五号","二十六号","二十七号","二十八号","二十九号","三十号","三十一号"]

let timeWords1 = ["零点","一点","二点","三点","四点","五点","六点","七点","八点","九点","十点","十一点","十二点","十三点","十四点","十五点","十六点","十七点","十八点","十九点","二十点","二十一点","二十二点","二十三点","二十四点","两点"]
let timeWords2 = ["十分","二十","三十","四十","五十","半"]

let dayToDayDictionary:Dictionary<String,Int> = ["一日":1,"二日":2,"三日":3,"四日":4,"五日":5,"六日":6,"七日":7,"八日":8,"九日":9,"十日":10,"十一日":11,"十二日":12,"十三日":13,"十四日":14,"十五日":15,"十六日":16,"十七日":17,"十八日":18,"十九日":19,"二十日":20,"二十一日":21,"二十二日":22,"二十三日":23,"二十四日":24,"二十五日":25,"二十六日":26,"二十七日":27,"二十八日":28,"二十九日":29,"三十日":30,"三十一日":31,"一号":1,"二号":2,"三号":3,"四号":4,"五号":5,"六号":6,"七号":7,"八号":8,"九号":9,"十号":10,"十一号":11,"十二号":12,"十三号":13,"十四号":14,"十五号":15,"十六号":16,"十七号":17,"十八号":18,"十九号":19,"二十号":20,"二十一号":21,"二十二号":22,"二十三号":23,"二十四号":24,"二十五号":25,"二十六号":26,"二十七号":27,"二十八号":28,"二十九号":29,"三十号":30,"三十一号":31]

let dayOffsetDictionary : Dictionary<String,Int> = ["今天":0,"明天":1,"后天":2,"周一":1,"周二":2,"周三":3,"周四":4,"周五":5,"周六":6,"周日":7,"周天":7,"星期一":1,"星期二":2,"星期三":3,"星期四":4,"星期五":5,"星期六":6,"星期天":7,"下周一":1,"下周二":2,"下周三":3,"下周四":4,"下周五":5,"下周六":6,"下周日":7,"一月":1,"二月":2,"三月":3,"四月":4,"五月":5,"六月":6,"七月":7,"八月":8,"九月":9,"十月":10,"十一月":11,"十二月":12]

let timeDictionary : Dictionary<String,Int> = ["零点":0,"一点":1,"二点":2,"两点":2,"三点":3,"四点":4,"五点":5,"六点":6,"七点":7,"八点":8,"九点":9,"十点":10,"十一点":11,"十二点":12,"十三点":13,"十四点":14,"十五点":15,"十六点":16,"十七点":17,"十八点":18,"十九点":19,"二十点":20,"二十一点":21,"二十二点":22,"二十三点":23,"二十四点":24]

let timeDictionary2 :Dictionary<String,Int> = ["十分":10,"二十":20,"三十":30,"半":30,"四十":40,"五十":50]
var reminderDateComponent = NSDateComponents()

func analyseString(text:String) {
    //var reminderDateComponent = NSDateComponents()
    reminderDateComponent.year = todayComponents.year
    reminderDateComponent.month = todayComponents.month
    reminderDateComponent.day = todayComponents.day
    reminderDateComponent.hour = todayComponents.hour
    print(reminderDateComponent.year)
    setAlarm = false
    var text1 = text
    var index = advance(text1.startIndex, 2)
    var hasDay = false
    var hasMonth = false
    var noonStatus = -1
    var hasHour = false
    var hasMinutes = false
    
    
    for preText1 in dayWords1 {
        if text1.hasPrefix(preText1) {
            reminderDateComponent.day = todayComponents.day + dayOffsetDictionary[preText1]!
            
            
            let index = advance(text1.startIndex, 2)
            text1 = text1.substringFromIndex(index)
            
            hasDay = true
            break
            
        }
    }
    
    if !hasDay {
        for preText2 in dayWords2 {
            if text1.hasPrefix(preText2) {
                var todayDay = todayComponents.weekday - 1
                if todayDay == 0 {
                    todayDay = 7
                }
                
                let weekDayOffset = dayOffsetDictionary[preText2]! - todayDay
                
                if weekDayOffset >= 0 {
                    reminderDateComponent.day = todayComponents.day + weekDayOffset
                } else {
                    reminderDateComponent.day = todayComponents.day + weekDayOffset + 6
                }
                
                let index = advance(text1.startIndex, 2)
                text1 = text1.substringFromIndex(index)
                
                hasDay = true
                
                break
            }
        }
    }
    
    
    if !hasDay {
        
        for preText3 in dayWords3 {
            if text1.hasPrefix(preText3) {
                
                var todayDay = todayComponents.weekday - 1
                if todayDay == 0 {
                    todayDay = 7
                }
                
                reminderDateComponent.day = todayComponents.day + (7 - todayDay) + dayOffsetDictionary[preText3]!
                
                
                let index = advance(text1.startIndex, 3)
                text1 = text1.substringFromIndex(index)
                
                
                hasDay = true
                
                break
                
            }
        }
        
    }
    
    
    
    
    for preText4 in dayWords4 {
        
        if text1.hasPrefix(preText4) {
            
            var index = advance(text1.startIndex, 2)
            reminderDateComponent.month = dayOffsetDictionary[preText4]!
            hasMonth = true
            
            if dayOffsetDictionary[preText4]! < 11 {
                text1 = text1.substringFromIndex(index)
            } else {
                index = advance(text1.startIndex, 3)
                text1 = text1.substringFromIndex(index)
            }
            
            for preText41 in dayWords5 {
                if text1.hasPrefix(preText41) {
                    
                    let tempDay:Int = dayToDayDictionary[preText41]!
                    reminderDateComponent.day = tempDay
                    
                    hasDay = true
                    
                    if tempDay <= 10 {
                        
                        index = advance(text1.startIndex, 2)
                        text1 = text1.substringFromIndex(index)
                        break
                        
                    } else if tempDay > 10 && tempDay < 21 || tempDay == 30 {
                        
                        index = advance(text1.startIndex, 3)
                        text1 = text1.substringFromIndex(index)
                        break
                        
                    } else if tempDay > 20 && tempDay < 30 || tempDay == 31 {
                        
                        index = advance(text1.startIndex, 4)
                        text1 = text1.substringFromIndex(index)
                        break
                    }
                }
            }
            
            
            break
            
        }
    }
    
    
    
    if !hasMonth && !hasDay {
        
        for preText5 in dayWords5 {
            
            if text1.hasPrefix(preText5) {
                
                let tempDay:Int = dayToDayDictionary[preText5]!
                reminderDateComponent.day = tempDay
                
                hasDay = true
                
                if tempDay <= 10 {
                    
                    index = advance(text1.startIndex, 2)
                    text1 = text1.substringFromIndex(index)
                    
                    break
                    
                } else if tempDay > 10 && tempDay < 21 || tempDay == 30 {
                    
                    index = advance(text1.startIndex, 3)
                    text1 = text1.substringFromIndex(index)
                    
                    break
                    
                } else if tempDay > 20 && tempDay < 30 || tempDay == 31 {
                    
                    index = advance(text1.startIndex, 4)
                    text1 = text1.substringFromIndex(index)
                    
                    break
                }
            }
        }
        
    }
    
    if !hasMonth && !hasDay {
        if Regex("\\d{4}").re(text1) {
            index = advance(text1.startIndex, 2)
            
            reminderDateComponent.month = text1.substringToIndex(index).toInt()!
            
            text1 = text1.substringFromIndex(index)
            
            reminderDateComponent.day = text1.substringToIndex(index).toInt()!
            hasMonth = true
            hasDay = true
            index = advance(text1.startIndex, 2)
            text1 = text1.substringFromIndex(index)
        }
    }
    
    if text1.hasPrefix("上午") || text1.hasPrefix("早晨") || text1.hasPrefix("早上") {
        index = advance(text1.startIndex, 2)
        text1 = text1.substringFromIndex(index)
        noonStatus = 1
    } else if text1.hasPrefix("中午") {
        index = advance(text1.startIndex, 2)
        text1 = text1.substringFromIndex(index)
        reminderDateComponent.hour = 12
        noonStatus = 3
    } else if text1.hasPrefix("下午") || text1.hasPrefix("晚上") {
        index = advance(text1.startIndex, 2)
        text1 = text1.substringFromIndex(index)
        noonStatus = 2
    }
    
    for preText6 in timeWords1 {
        
        if text1.hasPrefix(preText6) {
            var tempHour:Int = timeDictionary[preText6]!
            if tempHour <= 10 {
                //单字
                index = advance(text1.startIndex, 1)
                let m = text1.substringFromIndex(index)
                if m.hasPrefix("点") || m.hasPrefix("时") {
                    index = advance(text1.startIndex, 2)
                    text1 = text1.substringFromIndex(index)
                    
                    if noonStatus == 2 {
                        tempHour += 12
                    }
                    
                    reminderDateComponent.hour = tempHour
                    hasHour = true
                    
                    for preText61 in timeWords2 {
                        if text1.hasPrefix(preText61) {
                            reminderDateComponent.minute = timeDictionary2[preText61]!
                            
                            if preText61 == "半" {
                                index = advance(text1.startIndex, 1)
                                text1 = text1.substringFromIndex(index)
                            } else {
                                index = advance(text1.startIndex, 2)
                                text1 = text1.substringFromIndex(index)
                            }
                            hasMinutes = true
                            
                            break
                        }
                    }
                    
                    break
                }
                
                
            } else if tempHour <= 20 {
                //双字
                index = advance(text1.startIndex, 2)
                let m = text1.substringFromIndex(index)
                if m.hasPrefix("点") || m.hasPrefix("时") {
                    index = advance(text1.startIndex, 3)
                    text1 = text1.substringFromIndex(index)
                    reminderDateComponent.hour = tempHour
                    hasHour = true
                    
                    for preText61 in timeWords2 {
                        if text1.hasPrefix(preText61) {
                            reminderDateComponent.minute = timeDictionary2[preText61]!
                            
                            if preText61 == "半" {
                                index = advance(text1.startIndex, 1)
                                text1 = text1.substringFromIndex(index)
                            } else {
                                index = advance(text1.startIndex, 2)
                                text1 = text1.substringFromIndex(index)
                            }
                            hasMinutes = true
                            
                            break
                        }
                    }
                    
                    break
                }
                
            } else {
                //三字
                index = advance(text1.startIndex, 3)
                let m = text1.substringFromIndex(index)
                if m.hasPrefix("点") || m.hasPrefix("时") {
                    index = advance(text1.startIndex, 4)
                    text1 = text1.substringFromIndex(index)
                    reminderDateComponent.hour = tempHour
                    hasHour = true
                    
                    for preText61 in timeWords2 {
                        if text1.hasPrefix(preText61) {
                            reminderDateComponent.minute = timeDictionary2[preText61]!
                            
                            if preText61 == "半" {
                                index = advance(text1.startIndex, 1)
                                text1 = text1.substringFromIndex(index)
                            } else {
                                index = advance(text1.startIndex, 2)
                                text1 = text1.substringFromIndex(index)
                            }
                            hasMinutes = true
                            
                            break
                        }
                    }
                    
                    break
                }
            }
        }
    }

    println("\(reminderDateComponent.month)月")
    println("\(reminderDateComponent.day)号")
    if hasHour {
        println("\(reminderDateComponent.hour)时")
    }
    println("事件 \(text1)")
    reminderText = text1
    reminderTimeComponent = reminderDateComponent
    if hasHour || noonStatus == 3 {
        setAlarm = true
    } else {
        println("seeeeeee")
        println(reminderDateComponent.hour)
    }
    
}
