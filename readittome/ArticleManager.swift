//
//  ArticleManager.swift
//  readittome
//
//  Created by Hamilton Chapman on 30/06/2015.
//  Copyright (c) 2015 hc.gg. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


let defaults = NSUserDefaults.standardUserDefaults()
let pocketAccessToken = defaults.stringForKey("pocketAccessToken")!

class ArticleManager {
    
    class func fetchArticlesFromPocket() {
        println("fetching")
        let parameters = [
            "sort": "newest",
            "consumer_key": pocketConsumerKey,
            "access_token": pocketAccessToken
        ]
        
        Alamofire.request(.POST, "https://getpocket.com/v3/get", parameters: parameters, encoding: .JSON)
            .responseJSON() { (req, res, JSON, error) in
                if let list = JSON?["list"] as? [String:AnyObject] {
                    self.saveArticles(list)
                }
        }
    }
    
    class func saveArticles(articleList: [String:AnyObject]) {
        let realm = Realm()
        
        for (id, articleHash) in articleList {
            let article = Article()
            
            article.title = articleHash["resolved_title"] as! String
            article.url = articleHash["resolved_url"] as! String
            article.status = (articleHash["status"] as! String).toInt()!
            article.excerpt = articleHash["excerpt"] as! String
            article.id = id.toInt()!
             
            realm.write {
                realm.add(article, update: true)
            }
            println("stored \(id)")
        }
    }
    
}

