//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Max on 30/05/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }
    
    
    //MARK: - TableView Datasource Methods
    
    //Number of rows in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    //Update cells table view with categoryArray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
            cell.textLabel?.text = categories[indexPath.row].name
            
            return cell
            
        }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving ccategory, \(error)")
        }
        
        //Reload table view to show new item
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func aaButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
                
            self.saveCategories()
                
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
}
