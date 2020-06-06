//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Max on 30/05/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }
    
    
    //MARK: - TableView Datasource Methods
    
    //Number of rows in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If categories is "nil" then just return 1
        return categories?.count ?? 1
        
    }
    
    //Update cells table view with categoryArray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
            
            return cell
            
        }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(categories: Category) {
        
        do {
            try realm.write {
                realm.add(categories)
            }
        } catch {
            print("Error saving category, \(error)")
        }
        
        //Reload table view to show new item
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context, \(error)")
//        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func aaButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
//            self.categories.append(newCategory)
                
            self.save(categories: newCategory)
                
        }
        
        //Adding text field to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
    
    //Presenting alert to user after pressing add item button
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
}
