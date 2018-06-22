//
//  ViewController.swift
//  TodoList
//
//  Created by Kristopher Valas on 2/7/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import UIKit
import CoreData

class TableVC: UITableViewController{

    var itemModelArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
    }

    
    //MARK : table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemList", for: indexPath)
        let currentItem = itemModelArray[indexPath.row]
        cell.textLabel?.text = currentItem.title
        cell.accessoryType = currentItem.isChecked == true ? .checkmark : .none
        return cell
    }
    
    //MARK: call to actions
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemModelArray[indexPath.row].isChecked = !itemModelArray[indexPath.row].isChecked
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        let alertC = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            if let textString = alertC.textFields![0].text {
                if textString != " "{
                    let newItem = Item(context: self.context)
                    newItem.title = textString
                    newItem.isChecked = false
                    self.itemModelArray.append(newItem)
                    self.saveData()
                }
            }
            
        }
        
        alertC.addTextField { (textField) in
            textField.placeholder = "Please enter an item"
        }
        
        alertC.addAction(action)
        
        self.present(alertC, animated: true, completion: nil)
        
    }
    

    func saveData() {
        do{
            try context.save()
        } catch {
            print("Error saving item: \(error.localizedDescription)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do {
            itemModelArray = try context.fetch(request)
            
        }catch {
            print("Error attempting to fetch data: \(error.localizedDescription)")
        }
    }
    
}

//MARK: Search bar methods

extension TableVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let itemRequest : NSFetchRequest<Item> = Item.fetchRequest()
        itemRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        itemRequest.sortDescriptors =  [NSSortDescriptor(key: "title", ascending: true)]
        loadData(with: itemRequest)
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            tableView.reloadData()
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
            }
           
        }
    }
}

