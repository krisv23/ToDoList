//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Kristopher Valas on 6/21/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryList = [Categories]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let currentCat = categoryList[indexPath.row]
        cell.textLabel?.text = currentCat.name
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: Data manipulation
    
    func loadData() {
        let request : NSFetchRequest<Categories> = Categories.fetchRequest()
        do {
            categoryList = try context.fetch(request)
        }catch {
            print("Error trying to load data \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func storeData() {
        do {
            try context.save()
        }catch {
            print("Error trying to store data \(error.localizedDescription) ")
        }
    }

}
