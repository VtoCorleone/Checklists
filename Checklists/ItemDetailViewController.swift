//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Shane Chapman on 11/10/15.
//  Copyright © 2015 VtoCorleone. All rights reserved.
//

import UIKit


protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    /*
        OVERRIDES
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // segue came from EditItem
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
    
    // this makes the row so it is "unselectable" when the user taps the row but not in the text view
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // set focus to text field
        textField.becomeFirstResponder()
    }
    
    /*
        ACTIONS
    */
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        } else {
            let item = ChecklistItem(text: textField.text!, checked: false)
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    /*
        DELEGATE METHODS
    */
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)

        return true
    }
}
