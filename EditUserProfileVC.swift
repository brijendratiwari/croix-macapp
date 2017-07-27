//
//  EditUserProfileVC.swift
//  CorixMac
//
//  Created by Ignis IT  on 18/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

class EditUserProfileVC: NSViewController {
    @IBOutlet weak var scrollVw     = NSScrollView()
    
    @IBOutlet weak var userImage    = NSImageView()
    @IBOutlet weak var userFirstNm  = NSTextField()
    @IBOutlet weak var userLastNm   = NSTextField()
    @IBOutlet weak var userEmail    = NSTextField()
    @IBOutlet weak var phone        = NSTextField()
    @IBOutlet weak var company      = NSTextField()
    @IBOutlet weak var websiteURL   = NSTextField()
    @IBOutlet weak var userBio      = NSTextField()
    @IBOutlet weak var alias        = NSTextField()
    @IBOutlet var hoursShortFormateBtn: NSButton!
    @IBOutlet var hoursFullFormateBtn : NSButton!
    @IBOutlet var saveSocial: MyButton!
    
//    Address Info
    
    @IBOutlet weak var addressType  = NSTextField()
    @IBOutlet var country: NSPopUpButton!
    @IBOutlet weak var address      = NSTextField()
    @IBOutlet weak var apartment    = NSTextField()
    @IBOutlet weak var cityName     = NSTextField()
    @IBOutlet weak var stateNm      = NSTextField()
    @IBOutlet weak var zipCode      = NSTextField()
    
//    Social Media
    
    @IBOutlet weak var fbLink       = NSTextField()
    @IBOutlet weak var twitterLink  = NSTextField()
    @IBOutlet weak var redditLink   = NSTextField()
    @IBOutlet weak var instaLink    = NSTextField()
    @IBOutlet weak var snapChatLink = NSTextField()
    @IBOutlet weak var linkedinLink = NSTextField()
    @IBOutlet weak var otherLink    = NSTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let newScrollOrigin = NSPoint.init(x: 0, y: 2000)
        self.scrollVw?.documentView?.scroll(newScrollOrigin)
        
     
        var countries: [String] = []
        
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
        
        print(countries)
        
        country?.removeAllItems()
        country?.addItems(withTitles: countries)
        
        
        
        
        
        let tz = NSTimeZone.local
        let seconds: NSInteger = tz.secondsFromGMT(for: NSDate() as Date)
        
        print(NSDate.init(timeInterval: TimeInterval(seconds), since: NSDate() as Date))
        
        
        
        var isDaylightSavingTime: Bool { return TimeZone.current.isDaylightSavingTime(for: NSDate() as Date) }
        print(isDaylightSavingTime) // true (in effect)
        
        var daylightSavingTimeOffset: TimeInterval { return TimeZone.current.daylightSavingTimeOffset() }
        print(daylightSavingTimeOffset)  // 3600 seconds (1 hour - daylight savings time)
        
        
        var nextDaylightSavingTimeTransition: Date? { return TimeZone.current.nextDaylightSavingTimeTransition }    //  "Feb 18, 2017, 11:00 PM"
        print(nextDaylightSavingTimeTransition?.description(with: .current) ?? String())
        // "Saturday, February 18, 2017 at 11:00:00 PM Brasilia Standard Time\n"
        
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT() }
        print(secondsFromGMT)
        
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        print(localTimeZoneAbbreviation)
        
        var localTimeZoneName: String { return TimeZone.current.identifier }
        print(localTimeZoneName)
        
        var timeZoneAbbreviations: [String:String] { return TimeZone.abbreviationDictionary }
        print(timeZoneAbbreviations)
        
        var timeZoneIdentifiers: [String] { return TimeZone.knownTimeZoneIdentifiers }
        print(timeZoneIdentifiers)
        
        var nextDaylightSavingTimeTransitionAfterNext: Date? {
            guard
                let nextDaylightSavingTimeTransition = nextDaylightSavingTimeTransition
                else { return nil }
            return TimeZone.current.nextDaylightSavingTimeTransition(after: nextDaylightSavingTimeTransition)
        }
        
        let localMouseEventListener = NSEvent.addLocalMonitorForEvents(matching: NSEventMask.any) { (event: NSEvent) -> NSEvent? in
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        
        
        let currentDate = NSDate()
        
        let convertedDateString = dateFormatter.string(from: currentDate as Date)
        
        
        let date = dateFormatter.date(from: convertedDateString)
        
        // change to a readable time format and change to local time zone
        dateFormatter.timeZone = NSTimeZone.local
        print(dateFormatter.string(from: date!))
        
        userImage?.layer?.cornerRadius = (userImage?.frame.size.width)!/2
        userImage?.layer?.masksToBounds = true;
        
        let webHelper = APIHelper.apiCaller()
        let dict: NSDictionary = ["id":"1"]
        LoaderView.show(frame: self.view.bounds)
        webHelper.apiCall(method: "user", requestParams: dict) { (success, response) in
            print(response)
            LoaderView.hide()
            
            NSEvent.removeMonitor(localMouseEventListener ?? NSEvent())
            
            let respDict = response as! NSDictionary
            if success == true {
                let resp: NSDictionary = respDict.object(forKey: "data") as! NSDictionary
                
                let url = NSURL(string: resp.object(forKey: "photo") as! String)
                
                self.userImage?.image           = NSImage.init(byReferencing: url! as URL)
                self.userFirstNm?.stringValue   = resp.object(forKey: "first_name") as! String
                self.userLastNm?.stringValue    = resp.object(forKey: "last_name") as! String
                self.userEmail?.stringValue     = resp.object(forKey: "email") as! String
                self.phone?.stringValue         = resp.object(forKey: "phone") as! String
                self.company?.stringValue       = resp.object(forKey: "company") as! String
                self.websiteURL?.stringValue    = resp.object(forKey: "website") as! String
                self.userBio?.stringValue       = resp.object(forKey: "bio") as! String
                self.alias?.stringValue         = resp.object(forKey: "alias") as! String
                
//                Address Info
                
//                let add_resp: NSArray = resp.object(forKey: "addresses") as! NSArray
//                for addr in add_resp {
//                    
//                    let address: NSDictionary = addr as! NSDictionary
//                    
//                    self.addressType?.stringValue   = address.object(forKey: "type") as! String
//                    self.country?.stringValue       = address.object(forKey: "country") as! String
//                    self.address?.stringValue       = address.object(forKey: "address") as! String
//                    self.apartment?.stringValue     = address.object(forKey: "apt_unit") as! String
//                    self.cityName?.stringValue      = address.object(forKey: "city") as! String
//                    self.stateNm?.stringValue       = address.object(forKey: "state") as! String
//                    self.zipCode?.stringValue       = address.object(forKey: "zipcode") as! String
//                }
//                
////                Social Info
//                
//                self.fbLink?.stringValue        = resp.object(forKey: "fb") as! String
//                self.twitterLink?.stringValue   = resp.object(forKey: "twitter") as! String
//                self.redditLink?.stringValue    = resp.object(forKey: "reddit") as! String
//                self.instaLink?.stringValue     = resp.object(forKey: "instagram") as! String
//                self.snapChatLink?.stringValue  = resp.object(forKey: "snapchat") as! String
//                self.linkedinLink?.stringValue  = resp.object(forKey: "linkidin") as! String
//                self.otherLink?.stringValue     = resp.object(forKey: "other") as! String
                
            }
            else {
                DispatchQueue.main.async {
                    self.loginAlert(message: "Error !", title: respDict.object(forKey: "message") as! String)
                }
            }
        }
    }
    
   
    
    @IBAction func selectHoursFormate(_ sender: NSButton) {
        print("ygugugughvghvgvgvgvgvicfc")
    }
    
    func loginAlert(message: String, title: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = title
        alert.alertStyle = NSAlertStyle.informational
        alert.addButton(withTitle: "OK")
        return alert.runModal() == NSAlertFirstButtonReturn
    }
    
    @IBAction func select12HoursFormate(_ sender: NSButton) {
        print("12 ghante ho gaye :P")
    }
    
}
