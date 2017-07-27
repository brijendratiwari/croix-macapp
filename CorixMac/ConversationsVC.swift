//
//  ConversationsVC.swift
//  CorixMac
//
//  Created by Ignis IT  on 19/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa


class MessageCell: NSTableCellView {
    
    @IBOutlet public var msgTitle: NSTextField?
    @IBOutlet public var msgBody : NSTextField?
    
}


class CheckBoxCell: NSTableCellView {
    @IBOutlet public var checkBox: NSButton?
}



class ConversationsVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var conversationData = NSArray()
    var sectionListData  = NSArray()
    var sectionVal : NSInteger = 0
    
    var firstSecArr  = NSArray()
    var secondSecArr = NSArray()
    var thirdSecArr  = NSArray()
    
    @IBOutlet weak var tableV = NSTableView()
    @IBOutlet weak var listVW = NSTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let conversationArr = [["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"], ["checkFlag":0, "fname":"Rohit", "lname":"sharma", "title": "Re: Delivery status?", "msg":"I am still missing packages! Please send the delivery confirmation emails! :)", "msg_count":"7", "waitnig_time":"6 hr", "last_update":"Yesterday"], ["checkFlag":0, "fname":"Mike", "lname":"Shinoda", "title": "Re: do you offer any customization for corperate sponsors", "msg":"Hi Team, My name is Kevin and I wanted to reach out about customizing your produc…", "msg_count":"12", "waitnig_time":"3 days", "last_update":"jul 15"], ["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"], ["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"], ["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"], ["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"], ["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"], ["checkFlag":0, "fname":"David", "lname":"Warner", "title": "Are you interested in a business partnership?", "msg":"Another partnership opportunity. We're getting these left and right lately. Do you want…", "msg_count":"3", "waitnig_time":"2 hr", "last_update":"Today"]]
        
        
        let sectionsListArr = [[["name":"Unassigned", "count":"12"], ["name":"Mine", "count":"5"], ["name":"Assigned", "count":"3"], ["name":"Pending", "count":"2"], ["name":"Closed", "count":"1"], ["name":"Spam / Deleted", "count":"1"]],
                               
                               
                               
                               [["name":"General Email", "count":"14"], ["name":"Service Email", "count":"7"], ["name":"Brand Email", "count":"12"], ["name":"Chat", "count":"9"], ["name":"Facebook", "count":"9"], ["name":"Twitter", "count":"1"], ["name":"Instagram", "count":"2"], ["name":"Phone", "count":"5"], ["name":"Mentions", "count":"3"]],
                               
                               
                               
                               
                               
                               [["name":"Refund Requests", "count":"7"], ["name":"Demo Requests", "count":"0"]]]
        
        conversationData = conversationArr as NSArray
        sectionListData  = sectionsListArr as NSArray
        
        
//        self.view.frame = (NSApplication.shared().mainWindow?.frame)!
        
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        NSAnimationContext.runAnimationGroup({ (context: NSAnimationContext) in
            context.allowsImplicitAnimation = true
            self.listVW?.scrollRowToVisible(self.firstSecArr.count + self.secondSecArr.count + self.thirdSecArr.count + 2)
        }) {
            self.tableV?.scrollRowToVisible(self.conversationData.count)
            self.listVW?.scrollRowToVisible(0)

        }
        
//        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context){
//            context.allowsImplicitAnimation = YES;
//            [self.tableView scrollRowToVisible:someRow];
//            } completionHandler:NULL];
    }
    
    
    fileprivate enum CellIdentifiers {
        static let CheckBoxCell     = "CheckboxCell"
        static let UserNameCell     = "UserNameCell"
        static let MessageCell      = "MsgCell"
        static let MsgCountCell     = "MsgCountCell"
        static let TimeWaitingCell  = "TimeWaitingCell"
        static let LastUpdateCell   = "LastUpdateCell"
    }
    
    fileprivate enum SectionCellIdentifiers {
        static let SectionTitleCell         = "SectionTitleCell"
        static let SectionTitleCountCell    = "SectionTitleCountCell"
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == tableV {
            return conversationData.count
        }
        else if tableView == listVW {
            firstSecArr  = sectionListData[0] as! NSArray
            secondSecArr = sectionListData[1] as! NSArray
            thirdSecArr  = sectionListData[2] as! NSArray
            
            print("total cells count")
            print(firstSecArr.count + secondSecArr.count + thirdSecArr.count + 3);
            
            return firstSecArr.count + secondSecArr.count + thirdSecArr.count + 3
        }
        return 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableView == tableV {
            var text: String = ""
            var msg : String = ""
            var cellIdentifier: String = ""
            var stateVal : NSInteger = 0
            
            let conversationDict = conversationData.object(at: row) as! NSDictionary
            
            if tableColumn == tableView.tableColumns[0] {
                stateVal = conversationDict.object(forKey: "checkFlag") as! NSInteger
                cellIdentifier = CellIdentifiers.CheckBoxCell
            }
            else if tableColumn == tableView.tableColumns[1] {
                let fname = conversationDict.object(forKey: "fname") as! String
                let lname = conversationDict.object(forKey: "lname") as! String
                text = fname + " " + lname
                cellIdentifier = CellIdentifiers.UserNameCell
            }
            else if tableColumn == tableView.tableColumns[2] {
                text = conversationDict.object(forKey: "title") as! String
                msg  = conversationDict.object(forKey: "msg") as! String
                
                cellIdentifier = CellIdentifiers.MessageCell
            }
            else if tableColumn == tableView.tableColumns[3] {
                text = conversationDict.object(forKey: "msg_count") as! String
                cellIdentifier = CellIdentifiers.MsgCountCell
            }
            else if tableColumn == tableView.tableColumns[4] {
                text = conversationDict.object(forKey: "waitnig_time") as! String
                cellIdentifier = CellIdentifiers.TimeWaitingCell
            }
            else if tableColumn == tableView.tableColumns[5] {
                text = conversationDict.object(forKey: "last_update") as! String
                cellIdentifier = CellIdentifiers.LastUpdateCell
            }
            
            if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
                if tableColumn == tableView.tableColumns[0] {
                    var checkCell = CheckBoxCell()
                    checkCell = cell as! CheckBoxCell
                    
                    checkCell.checkBox?.state = stateVal
                    
                    return checkCell
                }
                if tableColumn == tableView.tableColumns[2] {
                    var msgCell = MessageCell()
                    msgCell = cell as! MessageCell
                    
                    msgCell.msgTitle?.stringValue = text
                    msgCell.msgBody?.stringValue  = msg
                    
                    return msgCell
                }
                else {
                    cell.textField?.stringValue = text
                    return cell
                }
            }
        }
        else if tableView == listVW {
            var title : String = ""
            var count : String = ""
            var cellIdentifier: String = ""
            
            if tableColumn == tableView.tableColumns[0] {
                if row == 0 {
                    title = "Conversation"
                }
                else if row == firstSecArr.count + 1 {
                    title = "Channels"
                }
                else if row == firstSecArr.count + secondSecArr.count + 2 {
                    title = "Folders"
                }
                else {
                    if row <= firstSecArr.count + 1 {
                        let dict = firstSecArr.object(at: row - 1) as! NSDictionary
                        title = dict.object(forKey: "name") as! String
                    }
                    else if row <= (firstSecArr.count + secondSecArr.count + 2) {
                        let dict = secondSecArr.object(at: row - firstSecArr.count - 2) as! NSDictionary
                        title = dict.object(forKey: "name") as! String
                        print("Title");
                        print(title);
                    }
                    else {
                        let dict = thirdSecArr.object(at: row - (firstSecArr.count + secondSecArr.count + 3)) as! NSDictionary
                        title = dict.object(forKey: "name") as! String
                        print("Title");
                        print(title);
                    }
                }
                cellIdentifier = SectionCellIdentifiers.SectionTitleCell
            }
            else if tableColumn == tableView.tableColumns[1] {
                if row == 0 {
                    count = ""
                }
                else if row == firstSecArr.count + 1 {
                    count = ""
                }
                else if row == firstSecArr.count + secondSecArr.count + 2 {
                    count = ""
                }
                else {
                    if row <= firstSecArr.count + 1 {
                        let dict = firstSecArr.object(at: row - 1) as! NSDictionary
                        count = dict.object(forKey: "count") as! String
                    }
                    else if row <= (firstSecArr.count + secondSecArr.count + 2) {
                        let dict = secondSecArr.object(at: row - firstSecArr.count - 2) as! NSDictionary
                        count = dict.object(forKey: "count") as! String
                    }
                    else {
                        let dict = thirdSecArr.object(at: row - (firstSecArr.count + secondSecArr.count + 3)) as! NSDictionary
                        count = dict.object(forKey: "count") as! String
                    }
                    if count == "0" {
                        count = ""
                    }
                }
                cellIdentifier = SectionCellIdentifiers.SectionTitleCountCell
            }
            
            if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
                if tableColumn == tableView.tableColumns[0] {
                    cell.textField?.stringValue = title
                    if row == 0 || row == firstSecArr.count + 1 || row == firstSecArr.count + secondSecArr.count + 2 {
                        cell.textField?.font = NSFont(name: (cell.textField?.font?.fontName)!, size: 18)!
                        cell.textField?.font = NSFont.boldSystemFont(ofSize: 18)
                    }
                }
                else {
                    cell.textField?.stringValue = count
                }
                return cell
            }
        }
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
    
}
