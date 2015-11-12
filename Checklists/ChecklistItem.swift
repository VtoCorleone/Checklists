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
    
    init (text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    /*
        PROTOCOL METHODS
    */
    let TEXT = "Text"
    let CHECKED = "Checked"
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: TEXT)
        aCoder.encodeBool(checked, forKey: CHECKED)
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey(TEXT) as! String
        checked = aDecoder.decodeBoolForKey(CHECKED)
        super.init()
    }
}