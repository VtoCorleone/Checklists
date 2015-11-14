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
    var iconName: String
    
    let NAME = "Name"
    let ITEMS = "Items"
    let ICONNAME = "IconName"
    
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    //MARK: - protocols for NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(NAME) as! String
        items = aDecoder.decodeObjectForKey(ITEMS) as![ChecklistItem]
        iconName = aDecoder.decodeObjectForKey(ICONNAME) as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: NAME)
        aCoder.encodeObject(items, forKey: ITEMS)
        aCoder.encodeObject(iconName, forKey: ICONNAME)
    }
    
    //MARK: - methods
    
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
    
}
