//
//  MyButton.swift
//  CorixMac
//
//  Created by Ignis IT  on 26/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

@IBDesignable

public class MyButton: NSButton {
    
    var bgClr: NSColor?
    var titleTxt: String?
    
    @IBInspectable var backGroundColor : NSColor! {
        set {
            bgClr = newValue
            
           
        }
        get {
            return self.bgClr
        }
    }
    @IBInspectable var titleText: String! {
        set {
            titleTxt = newValue
            
            
            
        }
        get {
            return titleTxt
        }
    }
    
    
    override public func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let image = NSImage.init(size: self.frame.size)
        image.lockFocus()
        bgClr?.drawSwatch(in: self.bounds)
        image.unlockFocus()
        
        self.isBordered = false
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center
        
        
        
        let cell = NSButtonCell.init(imageCell: image)
        cell.draw(withFrame: self.bounds, in: self)
        cell.drawTitle(NSAttributedString(string: titleTxt!, attributes: [ NSForegroundColorAttributeName : NSColor.white, NSParagraphStyleAttributeName : pstyle, NSFontAttributeName: NSFont.boldSystemFont(ofSize: 14) ]), withFrame: self.bounds, in: self)
    }
    
}
