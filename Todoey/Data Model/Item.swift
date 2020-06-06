//
//  Item.swift
//  Todoey
//
//  Created by Max on 04/06/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
