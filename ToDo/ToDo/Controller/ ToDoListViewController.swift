//
//  ViewController.swift
//  ToDo
//
//  Created by Julia Pabst on 02.02.24.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
          loadItems()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        //searchBar.delegate = self
    }
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = items?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ?  .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item =  items?[indexPath.row] {
            do {
                try self.realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Cannot update item checked or unchecked \(error)")
            }
            
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var currentText = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            
            
            if let text = currentText.text{
                
                if let currentCategory = self.selectedCategory {
                    do{
                        try self.realm.write{
                            let brandNewItem = Item()
                            brandNewItem.title = text
                            currentCategory.items.append(brandNewItem)
                            self.realm.add(currentCategory)
                        }
                    } catch {
                        print("Error saving items, \(error)")
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            currentText = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation
    func loadItems(){
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()
    }
    
}

//MARK - SearchBar
//extension ToDoListViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        
//        loadItems(with: request, predicate: predicate)
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItems()
//            
//            DispatchQueue.main.async{
//                searchBar.resignFirstResponder()
//            }
//        }
//}





