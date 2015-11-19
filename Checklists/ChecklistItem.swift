//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Shane Chapman on 11/10/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import Foundation

// NSObject is used for comparisons and NSCoding is used to serialize and save the data
class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    var itemId: Int
    
//    init (text: String, checked: Bool) {
//        self.text = text
//        self.checked = checked
//    }
    
    override init() {
        itemId = DataModel.nextChecklistItemID()
        super.init()
    }
    
    
    
    func toggleChecked() {
        checked = !checked
    }
    
    /*
        PROTOCOL METHODS
    */
    let TEXT = "Text"
    let CHECKED = "Checked"
    let DUEDATE = "DueDate"
    let SHOULDREMIND = "ShouldRemind"
    let ITEMID = "ItemId"
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
}