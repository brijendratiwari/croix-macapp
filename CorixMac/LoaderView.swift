//
//  LoaderView.swift
//  CorixMac
//
//  Created by Ignis IT  on 21/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa
import QuartzCore

class LoaderView: NSObject {
    
    static var transparentView : NSView? = nil
    static var loaderView : NSView? = nil
    static var activityV : NSProgressIndicator? = nil

    
    
    static var loader : LoaderView? = nil
    static func sharedLoader() -> LoaderView {
        if LoaderView.loader == nil {
            LoaderView.loader = LoaderView.init()
        }
        return LoaderView.loader!
    }
    
    static func initLoader(frame: CGRect) {
        if transparentView == nil {
            transparentView = NSView.init(frame: frame)
            transparentView?.wantsLayer = true
            transparentView?.layer?.backgroundColor = NSColor.init(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.3).cgColor
            
            loaderView = NSView.init(frame: NSRect.init(x: frame.size.width/2 - 75, y: frame.size.height/2 - 37, width: 150, height: 75))
            loaderView?.wantsLayer = true
            loaderView?.layer?.backgroundColor = NSColor.init(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.90).cgColor
            loaderView?.layer?.cornerRadius = 10
            
            activityV = NSProgressIndicator.init()
            activityV?.style = .spinningStyle
            activityV?.frame = NSRect.init(x: (loaderView?.frame.size.width)!/2 - 25, y: (loaderView?.frame.size.height)!/2 - 25, width: 50, height: 50)
            
            loaderView?.addSubview(activityV!)
            transparentView?.addSubview(loaderView!)
            
        }
    }
    
    static func show(frame: CGRect) {
        self.initLoader(frame: frame)
        
        let win: NSWindow = NSApplication.shared().mainWindow!
        win.contentView?.addSubview(transparentView!, positioned: NSWindowOrderingMode(rawValue: 1)!, relativeTo: nil)
        activityV?.startAnimation(self)
    }
    static func hide() {
        DispatchQueue.main.async {
            transparentView?.removeFromSuperview()
            activityV?.stopAnimation(activityV)
        }
    }
}
