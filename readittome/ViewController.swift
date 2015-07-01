//
//  ViewController.swift
//  readittome
//
//  Created by Hamilton Chapman on 30/06/2015.
//  Copyright (c) 2015 hc.gg. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
//        ArticleManager.fetchArticlesFromPocket()
        println("fetching")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("I have a access token")
        
        let articles = Realm().objects(Article)
        
        println(articles.count)
    }
}

