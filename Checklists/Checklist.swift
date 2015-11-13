//
//  Checklist.swift
//  Checklists
//
//  Created by Shane Chapman on 11/11/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    let NAME = "Name"
    let ITEMS = "Items"
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(NAME) as! String
        items = aDecoder.decodeObjectForKey(ITEMS) as![ChecklistItem]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: NAME)
        aCoder.encodeObject(items, forKey: ITEMS)
    }
}
