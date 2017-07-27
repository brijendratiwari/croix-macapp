//
//  FadeSegue.swift
//  CorixMac
//
//  Created by Ignis IT  on 17/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//
import Cocoa

import Foundation
class FadeSegue: NSStoryboardSegue {
//    override func perform() {
//        (sourceController as AnyObject).presentViewController(destinationController as! NSViewController,
//                                                              animator: )
//        super.perform()
//
//    }
    
    override init(identifier: String?, source sourceController: Any, destination destinationController: Any) {
        var myIdentifier : String
        if identifier == nil {
            myIdentifier = ""
        } else {
            myIdentifier = identifier!
        }
        super.init(identifier: myIdentifier, source: sourceController, destination: destinationController)
    }
    
    override func perform() {
        let sourceViewController = self.sourceController as! NSViewController
        let destinationViewController = self.destinationController as! NSViewController
        let containerViewController = sourceViewController.parent!
        
        containerViewController.insertChildViewController(destinationViewController, at: 1)
    }
}
