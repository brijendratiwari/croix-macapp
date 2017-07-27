//
//  APIHelper.swift
//  CorixMac
//
//  Created by Ignis IT  on 21/07/17.
//  Copyright © 2017 Ignis IT . All rights reserved.
//

import Cocoa

class APIHelper: NSObject {
    static var caller : APIHelper? = nil
    
    let baseUrl:String = "http://192.168.10.57:8181/api/v1/"
    typealias CompletionHandler = (_ success:Bool, _ response: Any) -> Void
    
    static func apiCaller() -> APIHelper {
        if APIHelper.caller == nil {
            APIHelper.caller = APIHelper.init()
        }
        return APIHelper.caller!
    }
    
    func apiCall(method: String, requestParams requestParam: NSDictionary, onComplete completionHandler: @escaping CompletionHandler) {
        let url:NSURL = NSURL(string: baseUrl + method)!
        let session = URLSession.shared
        let reqURL = NSMutableURLRequest(url: url as URL)
        
        if requestParam.count > 0 {
            reqURL.httpMethod = "POST"
            reqURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            reqURL.httpBody = try? JSONSerialization.data(withJSONObject: requestParam, options: .prettyPrinted)
        }
        else {
            reqURL.httpMethod = "GET"
        }
        
        reqURL.timeoutInterval = 2
        
        let task = session.dataTask(with: reqURL as URLRequest) { (data, response, error) in
            guard let data = data else {
                completionHandler(false, ["message":error?.localizedDescription ?? String(), "success":false])
                return }
            do {
                var exists: Bool = false

                if error != nil {
                    exists = false
                    DispatchQueue.global().async {
                        completionHandler(exists, ["message":error?.localizedDescription ?? String(), "success":false])
                    }
                }
                else if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let returnDataStr = String(data: data, encoding: .utf8)
                        let jsonResp = self.convertToDictionary(text: returnDataStr!)! as NSDictionary
                        print(jsonResp)
                        exists = jsonResp.object(forKey: "success") as! Bool
                        DispatchQueue.global().async {
                            completionHandler(exists, jsonResp)
                        }
                    } else if httpResponse.statusCode == 401 {
                        exists = false
                    }
                }
            } catch let error as NSError {
                DispatchQueue.global().async {
                    completionHandler(false, ["message":error.localizedDescription, "success":false])
                }
            }
        }
        task.resume()
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
