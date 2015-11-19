//
//  DataModel.swift
//  Checklists
//
//  Created by Shane Chapman on 11/12/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import Foundation

// this is a class so that it can be used as a reference and not value
class DataModel {
    var lists = [Checklist]()
    
    let CHECKLISTS = "Checklists"
    let CHECKLISTINDEX = "ChecklistIndex"
    let FIRSTTIME = "FirstTime"
    
    var indexOfSelectedChecklist: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(CHECKLISTINDEX)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: CHECKLISTINDEX)
        }
    }
    
    //MARK: - init
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    
    //MARK: - methods    
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Checklists.plist")
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        print(path)
        // check if file exists (no file when app loads for the first time)
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey(CHECKLISTS) as! [Checklist]
                
                unarchiver.finishDecoding()
                sortChecklists()
            }
        }
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: CHECKLISTS)
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func registerDefaults() {
        let dictionary = [CHECKLISTINDEX: -1, FIRSTTIME: true, "ChecklistItemID": 0]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    // if this is the first launch, create a default list called "List"
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey(FIRSTTIME)
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefaults.setBool(false, forKey: FIRSTTIME)
            userDefaults.synchronize()
        }
    }
    
    func sortChecklists() {
        lists.sortInPlace({ checklist1, checklist2 in return checklist1.name.localizedStandardCompare(checklist2.name) == .OrderedAscending })
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let itemID = userDefaults.integerForKey("ChecklistItemID")
        userDefaults.setInteger(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
}