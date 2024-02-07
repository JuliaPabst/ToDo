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
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ?  .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /* context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row) */
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var currentText = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            
            
//            if let text = currentText.text{
//                let brandNewItem = Item()
//                brandNewItem.title = text
//                brandNewItem.done = false
//                brandNewItem.parentCategory = self.selectedCategory
//                self.itemArray.append(brandNewItem)
//                
//                self.saveItems()
//                self.tableView.reloadData()
//            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            currentText = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation
    func saveItems(){
        do{
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        self.tableView.reloadData()
    }
    

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





