//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Shane Chapman on 11/10/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    init (text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
    func toggleChecked() {
        checked = !checked
    }
}