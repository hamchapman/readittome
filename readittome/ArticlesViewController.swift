//
//  ArticlesViewController.swift
//  readittome
//
//  Created by Sylvain Giuliani on 01/07/2015.
//  Copyright (c) 2015 hc.gg. All rights reserved.
//

import UIKit
import RealmSwift

class ArticlesViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles:Results<Article>?

    
    @IBOutlet var articlesTableView: UITableView?


    @IBAction func SignOutPocket(sender: UIBarButtonItem) {
        Realm().write {
            Realm().deleteAll()
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("pocketAccessToken")
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let pocketAuthModalController = storyBoard.instantiateViewControllerWithIdentifier("pocketAuthModalController") as! PocketAuthViewController
        self.presentViewController(pocketAuthModalController, animated:true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        ArticleManager.fetchArticlesFromPocket()
        
        articles = Realm().objects(Article)
        
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ArticleCell")
    
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles!.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = articles![indexPath.row].title

        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        println("\(articles![indexPath.row].title)")
    }
}
