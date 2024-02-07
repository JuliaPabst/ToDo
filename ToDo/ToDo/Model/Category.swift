//
//  Category.swift
//  ToDo
//
//  Created by Julia Pabst on 07.02.24.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

