//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Shane Chapman on 11/10/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import Foundation
import UIKit

// NSObject is used for comparisons and NSCoding is used to serialize and save the data
class ChecklistItem: NSObject, NSCoding {

    /*
        MARK: - Variables
    */
    
    let TEXT = "Text"
    let CHECKED = "Checked"
    let DUEDATE = "DueDate"
    let SHOULDREMIND = "ShouldRemind"
    let ITEMID = "ItemId"
    
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    var itemId: Int
    
    /*
        MARK: - Life cycle
    */
    
    override init() {
        itemId = DataModel.nextChecklistItemID()
        super.init()
    }
    
    // this is called when an object is about to be deleted
    deinit {
        if let notification = notificationForThisItem() {
            print("Removing existing notification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
    }
    
    /*
        MARK: - Protocol methods
    */
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: TEXT)
        aCoder.encodeBool(checked, forKey: CHECKED)
        aCoder.encodeObject(dueDate, forKey: DUEDATE)
        aCoder.encodeBool(shouldRemind, forKey: SHOULDREMIND)
        aCoder.encodeInteger(itemId, forKey: ITEMID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey(TEXT) as! String
        checked = aDecoder.decodeBoolForKey(CHECKED)
        dueDate = aDecoder.decodeObjectForKey(DUEDATE) as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey(SHOULDREMIND)
        itemId = aDecoder.decodeIntegerForKey(ITEMID)
        super.init()
    }
    
    /*
        MARK: - Methods
    */
    
    func toggleChecked() {
        checked = !checked
    }
    
    func scheduleNotification() {
        let existingNotification = notificationForThisItem()
        if let notification = existingNotification {
            print("Found an existing notification \(notification)")
            UIApplication.sharedApplication().cancelLocalNotification(notification)
        }
        
        if shouldRemind && dueDate.compare(NSDate()) != .OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            // add to userInfo dictionary in case you need to cancel it later
            localNotification.userInfo = [ITEMID: itemId]
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            print("Scheduled notification \(localNotification) for itemId \(itemId)")
        }
    }
    
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications!
        
        for notification in allNotifications {
            if let number = notification.userInfo?[ITEMID] as? Int where number == itemId {
                return notification
            }
        }
        return nil
    }
    
}