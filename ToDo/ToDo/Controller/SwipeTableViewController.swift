//
//  SwipeTableViewController.swift
//  ToDo
//
//  Created by Julia Pabst on 09.02.24.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Table View Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        print("Delete Cell")
        
        //        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        //            if let currentCategory = self.categories?[indexPath.row]{
        //                do {
        //                    try self.realm.write {
        //                        self.realm.delete(currentCategory)
        //                    }
        //                } catch {
        //                    print("Cannot delete  item checked \(error)")
        //                }
        //            }
        //        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
}
