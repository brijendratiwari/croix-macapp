//
//  ProfileVC.swift
//  CorixMac
//
//  Created by Ignis IT  on 15/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

class ProfileVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var containerView = NSView()
    @IBOutlet weak var settingTable  = NSTableView()
        
    var displayView = NSView()
    var idxVal : NSInteger = -1
    var tableData : NSArray = ["Profile", "Notifications", "My Things", "My Documents", "Security"]
    var storyBoardIds : NSArray = ["EditUserProfileVC", "PermissionVC", "ConversationsVC", "PeoplesListVC", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyBoard : NSStoryboard   = NSStoryboard(name: "Main", bundle:nil)
        let sourceViewController        = storyBoard.instantiateController(withIdentifier: "EditUserProfileVC") as! NSViewController
        
        displayView = sourceViewController.view
        containerView?.addSubview(sourceViewController.view)
    }
    
    fileprivate enum CellIdentifiers {
        static let SettingCell = "SettingCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""

        if tableColumn == tableView.tableColumns[0] {
            text = tableData[row] as! String
            cellIdentifier = CellIdentifiers.SettingCell
        }
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if row != idxVal {
            self.didSelectRowAtIndex(val: row)
        }
        return true
    }

    func didSelectRowAtIndex(val: NSInteger) {
        idxVal = val
        if idxVal == storyBoardIds.count - 1 {
            let storyBoard : NSStoryboard = NSStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateController(withIdentifier: "ViewController") as! ViewController
            if let window = self.view.window {
                NSAnimationContext.runAnimationGroup({ (context) -> Void in
                    self.view.animator().alphaValue = 0
                    
                    nextViewController.view.alphaValue = 0
                    window.contentViewController = nextViewController
                    nextViewController.view.animator().alphaValue = 1.0
                }, completionHandler: { () -> Void in
                    
                })
            }
        }
        else {
            displayView.removeFromSuperview()
            
            let storyBoard : NSStoryboard   = NSStoryboard(name: "Main", bundle:nil)
            let sourceViewController        = storyBoard.instantiateController(withIdentifier: storyBoardIds[val] as! String) as! NSViewController
            
            displayView = sourceViewController.view
            displayView.frame = (containerView?.bounds)!
            containerView?.addSubview(sourceViewController.view)
        }
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        settingTable?.enumerateAvailableRowViews({ (rowView: NSTableRowView, row: NSInteger) in
            let tableCell: NSTableCellView = rowView.view(atColumn: 0) as! NSTableCellView
            if rowView.isSelected {
                tableCell.textField?.textColor = NSColor.init(red: 30/255, green: 132/255, blue: 251/255, alpha: 1)
            }
            else {
                tableCell.textField?.textColor = NSColor.white
            }
        })
    }
}
