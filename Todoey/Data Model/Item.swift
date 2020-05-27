//
//  Item.swift
//  Todoey
//
//  Created by Max on 26/05/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    
    //To be encodable, all of a class's data types must be standard types
    var title: String = ""
    var done: Bool = false
    
}
