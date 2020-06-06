//
//  Category.swift
//  Todoey
//
//  Created by Max on 04/06/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
