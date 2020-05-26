//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Max on 24/05/2020.
//  Copyright © 2020 Max Thomas. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Find Mike","Buy Eggos","Defeat Demogorgan"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
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
    
}
