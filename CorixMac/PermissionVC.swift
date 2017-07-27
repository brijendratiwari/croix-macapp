//
//  PermissionVC.swift
//  CorixMac
//
//  Created by Ignis IT  on 18/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

protocol CheckBoxDelegate: class {
    func checkedTickBox(sender: NSButton)
}

class TeamsDataCell: NSTableCellView {
    @IBOutlet public var teamsNmTxt: NSTextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



class FullCheckBoxCell: NSTableCellView {
    @IBOutlet public var tickFullCheckBox: NSButton?
    
    public var tickDelegate: CheckBoxDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkBoxClick(_ sender: NSButton) {
        
        Swift.print("Matlab aa rha hai")
        self.tickDelegate?.checkedTickBox(sender: tickFullCheckBox!)
    }
}



class CustomCheckBoxCell: NSTableCellView {
    @IBOutlet public var tickCustomCheckBox: NSButton?
    
    public var tickDelegate: CheckBoxDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func checkBoxClick(_ sender: NSButton) {
        
        Swift.print("Matlab aa rha hai")
        self.tickDelegate?.checkedTickBox(sender: tickCustomCheckBox!)
    }
}



class NoneCheckBoxCell: NSTableCellView {
    @IBOutlet public var tickNoneCheckBox: NSButton?

    public var tickDelegate: CheckBoxDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func checkBoxClick(_ sender: NSButton) {
        
        Swift.print("Matlab aa rha hai")
        self.tickDelegate?.checkedTickBox(sender: tickNoneCheckBox!)
    }
}



class PermissionVC: NSViewController, NSTableViewDataSource, NSTableViewDelegate, CheckBoxDelegate {
    
    @IBOutlet weak var tableV = NSTableView()
    var teamsArr : NSMutableArray = [["name":"Sales", "full":1, "custom":0, "none":1], ["name":"Marketing + PR", "full":1, "custom":0, "none":0], ["name":"Customer Support", "full":1, "custom":0, "none":1], ["name":"Production + Services", "full":1, "custom":1, "none":0], ["name":"Fundraising", "full":1, "custom":0, "none":0], ["name":"Logistics", "full":1, "custom":0, "none":0], ["name":"Human Resources", "full":1, "custom":0, "none":0], ["name":"Accounting", "full":1, "custom":0, "none":0], ["name":"Sites", "full":0, "custom":1, "none":0], ["name":"Research + Development", "full":0, "custom":0, "none":1]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        NSAnimationContext.runAnimationGroup({ (context: NSAnimationContext) in
            context.allowsImplicitAnimation = true
            self.tableV?.scrollRowToVisible(self.teamsArr.count - 1)
        }) {
            self.tableV?.scrollRowToVisible(0)
        }
    }
    
    fileprivate enum CellIdentifiers {
        static let TeamsDataCell        = "TeamsDataCell"
        static let FullCheckBoxCell     = "FullCheckBoxCell"
        static let CustomCheckBoxCell   = "CustomCheckBoxCell"
        static let NoneCheckBoxCell     = "NoneCheckBoxCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return teamsArr.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = ""
        var cellIdentifier: String = ""
        var btnState: NSInteger = 0
        
        let dataDict = teamsArr[row] as! NSDictionary
        if tableColumn == tableView.tableColumns[0] {
            text = dataDict.object(forKey: "name") as! String
            cellIdentifier = CellIdentifiers.TeamsDataCell
        }
        else if tableColumn == tableView.tableColumns[1] {
            btnState = dataDict.object(forKey: "full") as! NSInteger
            cellIdentifier = CellIdentifiers.FullCheckBoxCell
        }
        else if tableColumn == tableView.tableColumns[2] {
            btnState = dataDict.object(forKey: "custom") as! NSInteger
            cellIdentifier = CellIdentifiers.CustomCheckBoxCell
        }
        else if tableColumn == tableView.tableColumns[3] {
            btnState = dataDict.object(forKey: "none") as! NSInteger
            cellIdentifier = CellIdentifiers.NoneCheckBoxCell
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            if tableColumn == tableView.tableColumns[0] {
                var teamCell = TeamsDataCell()
                teamCell = cell as! TeamsDataCell
                teamCell.teamsNmTxt?.stringValue = text;
                return teamCell
            }
            else if tableColumn == tableView.tableColumns[1] {
                var fullCheckcell = FullCheckBoxCell()
                fullCheckcell = cell as! FullCheckBoxCell
                fullCheckcell.tickFullCheckBox?.state = btnState
                
                fullCheckcell.tickFullCheckBox?.tag = 1000 + row
                
                fullCheckcell.tickDelegate = self
                
                return fullCheckcell
            }
            else if tableColumn == tableView.tableColumns[2] {
                var customCheckcell = CustomCheckBoxCell()
                customCheckcell = cell as! CustomCheckBoxCell
                customCheckcell.tickCustomCheckBox?.state = btnState
                
                customCheckcell.tickCustomCheckBox?.tag = 2000 + row
                
                customCheckcell.tickDelegate = self
                
                return customCheckcell
            }
            else if tableColumn == tableView.tableColumns[3] {
                var noneCheckcell = NoneCheckBoxCell()
                noneCheckcell = cell as! NoneCheckBoxCell
                noneCheckcell.tickNoneCheckBox?.state = btnState
                
                noneCheckcell.tickNoneCheckBox?.tag = 3000 + row
                
                noneCheckcell.tickDelegate = self
                
                return noneCheckcell
            }
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
    
    func checkedTickBox(sender: NSButton) {
        var fulltagVal = NSInteger()
        var customtagVal = NSInteger()
        var nonetagVal = NSInteger()
        var idxVal = NSInteger()
        
        if sender.tag > 999 && sender.tag < 2000 {
            fulltagVal = sender.state
            customtagVal = 0
            nonetagVal = 0
            
            idxVal = sender.tag - 1000
        }
        else if sender.tag > 1999 && sender.tag < 3000 {
            customtagVal = sender.state
            fulltagVal = 0
            nonetagVal = 0
            
            idxVal = sender.tag - 2000
        }
        else if sender.tag > 2999 && sender.tag < 4000 {
            nonetagVal = sender.state
            customtagVal = 0
            fulltagVal = 0
            
            idxVal = sender.tag - 3000
        }
        let dataDict = teamsArr[idxVal] as! NSDictionary
        
        teamsArr.replaceObject(at: idxVal, with: ["name":dataDict.object(forKey: "name"), "full":fulltagVal, "custom":customtagVal, "none":nonetagVal])
        
        tableV?.reloadData()
    }
    
    
    
    @IBAction func checkPermissionTickBox(sender : NSButton) {
        
    }
    
}
