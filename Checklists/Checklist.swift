//
//  Checklist.swift
//  Checklists
//
//  Created by Shane Chapman on 11/11/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
