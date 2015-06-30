//
//  Article.swift
//  readittome
//
//  Created by Hamilton Chapman on 30/06/2015.
//  Copyright (c) 2015 hc.gg. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {
    dynamic var id = 0
    dynamic var url = ""
    dynamic var title = ""
    dynamic var excerpt = ""
    dynamic var body = ""
    dynamic var status = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

enum PocketReadStatus {
    case Unread
    case Read
}