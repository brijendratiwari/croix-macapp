//
//  UserProfileVC.swift
//  CorixMac
//
//  Created by Ignis IT  on 20/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

class UserProfileVC: NSViewController {
    @IBOutlet weak var scrollVw      = NSScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let newScrollOrigin = NSPoint.init(x: 0, y: 1500)
        scrollVw?.documentView?.scroll(newScrollOrigin)
    }
    
}
