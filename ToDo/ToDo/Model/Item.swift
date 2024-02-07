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
}
