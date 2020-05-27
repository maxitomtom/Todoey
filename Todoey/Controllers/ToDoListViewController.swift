import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
    
        let newItem3 = Item()
        newItem3.title = "Destrol Demogorgon"
        itemArray.append(newItem3)
        
        //Check whether user's default list is populated and if it is then use it to launch app
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            
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
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator replaces the 5 lines of if else below
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    //MARK: - Tableview Delegate Methods
    
    //Fires whenever we click on any cell in the table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        //Sets done property to be opposite of current propert.
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //Line above replaces these 5 lines of code:
//        if itemArray[indexPath.row].done == true {
//            itemArray[indexPath.row].done = false
//        }
//        else {
//            itemArray[indexPath.row].done = true
//        }

        tableView.reloadData()
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
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
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
