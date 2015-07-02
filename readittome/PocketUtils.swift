//
//  PocketUtils.swift
//  readittome
//
//  Created by Hamilton Chapman on 30/06/2015.
//  Copyright (c) 2015 hc.gg. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let pocketConsumerKey = "42523-e96ad3f09e1a0796bdbe05a8"
let pocketRedirectUri = "readitome-login://pocket"
var pocketRequestCode = ""



func authPocket() {
    let parameters = [
        "redirect_uri": pocketRedirectUri,
        "consumer_key": pocketConsumerKey
    ]
    
    Alamofire.request(.POST, "https://getpocket.com/v3/oauth/request", parameters: parameters,  encoding: .JSON).responseString(encoding: NSUTF8StringEncoding) {
        (req, response, data, error) in
        // This should be Async ?
        if error != nil {
            NSLog("got error while auth Pocket: \(error)")
        }
        let code = data!.componentsSeparatedByString("=")[1] as String
        pocketRequestCode = code
        
        let sendURL = NSURL(string: "https://getpocket.com/auth/authorize?request_token=\(code)&redirect_uri=\(pocketRedirectUri)&mobile=1")!
        UIApplication.sharedApplication().openURL(sendURL)
    }
}


func authPocketWithUrl(url: NSURL, callback: () -> Void) {
    
    let parameters = [
        "consumer_key": pocketConsumerKey,
        "code": pocketRequestCode
    ]
    Alamofire.request(.POST, "https://getpocket.com/v3/oauth/authorize", parameters: parameters, encoding: .JSON).responseString(encoding: NSUTF8StringEncoding) {
        (req, response, data, error) in
        if error != nil {
            NSLog("error while getting token: \(error)")
        }
        let params = data!.componentsSeparatedByString("&") as [String]
        
        let pocketAccessToken = params[0].componentsSeparatedByString("=")[1]
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(pocketAccessToken, forKey: "pocketAccessToken")
        println("stored, calling the callback yo")
        callback()
    }
}