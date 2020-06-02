
import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        self.saveItems()
        
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
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItems()
            
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
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        //Reload table view to show new item
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        // Replacing two lines below with optional binding above so we're never unwrapping a nil value.
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//        request.predicate = compoundPredicate
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
       
        tableView.reloadData()
        
    }
    
}

//MARK: - Search Bar Methods

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
    
}
 
