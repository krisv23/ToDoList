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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
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
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        let alertC = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            if let textString = alertC.textFields![0].text {
                if textString != " "{
                    self.itemModelArray.append(ItemModel(textString, false))
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
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemModelArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array")
        }
        self.tableView.reloadData()
    }
    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemModelArray = try decoder.decode([ItemModel].self, from: data)
            }catch {
                print("Error : \(error.localizedDescription)")
            }
        }


    }
    
}

