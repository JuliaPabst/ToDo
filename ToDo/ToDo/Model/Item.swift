//
//  Item.swift
//  ToDo
//
//  Created by Julia Pabst on 07.02.24.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date(timeIntervalSince1970: 0)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
