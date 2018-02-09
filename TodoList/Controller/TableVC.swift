//
//  ViewController.swift
//  TodoList
//
//  Created by Kristopher Valas on 2/7/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {

    var itemModelArray = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK : table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemList", for: indexPath)
        let selectedItem = itemModelArray[indexPath.row]
        cell.textLabel?.text = selectedItem.title
        cell.accessoryType = selectedItem.isChecked == true ? .checkmark : .none
        return cell
    }
    
    //MARK: call to actions
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemModelArray[indexPath.row].isChecked = !itemModelArray[indexPath.row].isChecked
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        let alertC = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            if let textString = alertC.textFields![0].text {
                if textString != " "{
                    self.itemModelArray.append(ItemModel(textString, false))
                    self.tableView.reloadData()
                }
            }
            
        }
        
        alertC.addTextField { (textField) in
            textField.placeholder = "Please enter an item"
        }
        
        alertC.addAction(action)
        
        self.present(alertC, animated: true, completion: nil)
        
    }
    
}

