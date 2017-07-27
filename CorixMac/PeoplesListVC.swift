//
//  PeoplesListVC.swift
//  CorixMac
//
//  Created by Ignis IT  on 19/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

class PeoplesListVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var conversationData = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let conversationArr = [["fname":"David", "lname":"Warner", "email": "DW@test.com", "Location":"Paddington, Australia", "userType":"Opner", "last_activity":"Champions Trophy"], ["fname":"Rohit", "lname":"Sharma", "email": "RS@test.com", "Location":"Mumbai, India", "userType":"Captain", "last_activity":"Champion Trophy"], ["fname":"Steve", "lname":"Smith", "email": "SS@test.com", "Location":"Sydney, Australia", "userType":"Batsman", "last_activity":"Champion Trophy"], ["fname":"Virat", "lname":"Kohli", "email": "VK@test.com", "Location":"Delhi, India", "userType":"One Down Batsman", "last_activity":"Indies Tour"], ["fname":"Shane", "lname":"Watson", "email": "SW@test.com", "Location":"Queensland, Australia", "userType":"All Rounder", "last_activity":"Champion Trophy"]]
        
        conversationData = conversationArr as NSArray
    }
    fileprivate enum CellIdentifiers {
        static let UserNameCell     = "UserNameCell"
        static let EmailCell        = "EmailCell"
        static let LocationCell     = "LocationCell"
        static let UserTypeCell     = "UserTypeCell"
        static let LastActivityCell = "LastActivityCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return conversationData.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""
        
        let conversationDict = conversationData.object(at: row) as! NSDictionary
        
        if tableColumn == tableView.tableColumns[0] {
            let fname = conversationDict.object(forKey: "fname") as! String
            let lname = conversationDict.object(forKey: "lname") as! String
            text = fname + " " + lname
            cellIdentifier = CellIdentifiers.UserNameCell
        }
        else if tableColumn == tableView.tableColumns[1] {
            text = conversationDict.object(forKey: "email") as! String
            
            cellIdentifier = CellIdentifiers.EmailCell
        }
        else if tableColumn == tableView.tableColumns[2] {
            text = conversationDict.object(forKey: "Location") as! String
            cellIdentifier = CellIdentifiers.LocationCell
        }
        else if tableColumn == tableView.tableColumns[3] {
            text = conversationDict.object(forKey: "userType") as! String
            cellIdentifier = CellIdentifiers.UserTypeCell
        }
        else if tableColumn == tableView.tableColumns[4] {
            text = conversationDict.object(forKey: "last_activity") as! String
            cellIdentifier = CellIdentifiers.LastActivityCell
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
}
