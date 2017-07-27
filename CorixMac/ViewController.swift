//
//  ViewController.swift
//  CorixMac
//
//  Created by Ignis IT  on 15/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var userNm    = NSTextField()
    @IBOutlet weak var password  = NSSecureTextField()
    @IBOutlet weak var signInBtn = NSButton()
    @IBOutlet weak var forgotBtn = NSButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        
        signInBtn?.attributedTitle = NSAttributedString(string: "Sign In", attributes: [ NSForegroundColorAttributeName : NSColor.black, NSParagraphStyleAttributeName : pstyle ])
        
        
        forgotBtn?.attributedTitle = NSAttributedString(string: "Forgot Password?", attributes: [ NSForegroundColorAttributeName : NSColor.white, NSParagraphStyleAttributeName : pstyle ])

    }
    override func viewDidAppear() {
        super.viewDidAppear()
        
        signInBtn?.wantsLayer = true
        signInBtn?.layer?.backgroundColor = NSColor.black.cgColor
        signInBtn?.layer?.masksToBounds   = true
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func forgotPassword(sender: NSButton) {
        
    }
    
    @IBAction func loginBtnTapped(sender: NSButton) {
        LoaderView.show(frame: self.view.bounds)
        if (userNm?.stringValue == "") && password?.stringValue == "" {
            DispatchQueue.main.async {
                self.loginAlert(message: "Alert !", title: "Please enter both userID and Password")
            }
        }
        let localMouseEventListener = NSEvent.addLocalMonitorForEvents(matching: NSEventMask.any) { (event: NSEvent) -> NSEvent? in
            return nil
        }
        let webHelper = APIHelper.apiCaller()
        
        let dict: NSDictionary = ["email":userNm?.stringValue ?? String(), "password":password?.stringValue ?? String()]
        webHelper.apiCall(method: "login", requestParams: dict) { (success, response) in
            print(response)
            LoaderView.hide()
            
            NSEvent.removeMonitor(localMouseEventListener ?? NSEvent())

            let resp = response as! NSDictionary
            let storyBoard : NSStoryboard = NSStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateController(withIdentifier: "ProfileCntl") as! ProfileVC
            DispatchQueue.main.async {
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
//            if success == true {
//            }
//            else {
//                DispatchQueue.main.async {
//                    self.loginAlert(message: "Error !", title: resp.object(forKey: "message") as! String)
//                }
//            }
        }
    }
    
    func loginAlert(message: String, title: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = title
        alert.alertStyle = NSAlertStyle.critical
        alert.addButton(withTitle: "OK")
        return alert.runModal() == NSAlertFirstButtonReturn
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
