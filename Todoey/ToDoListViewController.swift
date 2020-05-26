//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Max on 24/05/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos","Defeat Demogorgan"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Check whether user's default list is populated and if it is then use it to launch app
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            
            itemArray = items
            
        }
        
    }

    //MARK: - Tableview Datasource Methods
    
    //Number of rows in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    //Update cells in table view with itemArray
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    //Fires whenever we click on any cell in the table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        //Remove checkmark if the cell already has one
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else {
            
            //Adding checkmark to selection
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }

        //Changing selection to flash grey rather than stay grey
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        //Need to create a variable that can be used within all scopes i.e. within the alert closure below.
        var textField: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //What will happen once the user clicks the Add Item button on our UI Alert
            self.itemArray.append(textField.text!)
            
            //Save new array to User Defaults
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            //Reload table view to show new item
            self.tableView.reloadData()
            
        }
        
        //Adding text field to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            //alertTextField doesn't exist outside of this scope so need to attach it to the more "global" variable. This is called "extending the scope"
            textField = alertTextField
        }
        
        //Presenting alert to user after pressing add item button
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    
}
