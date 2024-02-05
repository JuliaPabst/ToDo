//
//  Item.swift
//  ToDo
//
//  Created by Julia Pabst on 04.02.24.
//

import Foundation

class Item: Encodable, Decodable {
    var title: String = ""
    var done: Bool = false
}
