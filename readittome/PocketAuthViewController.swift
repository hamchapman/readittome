//
//  PocketAuthViewController.swift
//  readittome
//
//  Created by Hamilton Chapman on 30/06/2015.
//  Copyright (c) 2015 hc.gg. All rights reserved.
//

import UIKit

class PocketAuthViewController: UIViewController {

    @IBAction func PocketAuthButton(sender: AnyObject) {
        authPocket()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Pocket auth controller is loaded")

        // Do any additional setup after loading the view.
    }

}
