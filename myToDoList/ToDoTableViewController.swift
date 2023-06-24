import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    var toDoCDs: [ToDoCD] = []
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                if let toDos = toDosFromCoreData as? [ToDoCD] {
                    toDoCDs = toDos
                    tableView.reloadData()
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 222/256, green: 220/256, blue: 217/256, alpha: 1.0)]
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 75/256, green: 107/256, blue: 82/256, alpha: 1.0)
    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let itemMove = toDoCDs[sourceIndexPath.row]
            toDoCDs.remove(at: sourceIndexPath.row)
            toDoCDs.insert(itemMove, at: destinationIndexPath.row)
        }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCDs.count
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor(red: 75/256, green: 107/256, blue: 82/256, alpha: 1.0)
        cell.layer.borderWidth = 0.25
        cell.layer.borderColor = UIColor.black.cgColor
        cell.textLabel?.textColor = UIColor(red: 222/256, green: 220/256, blue: 217/256, alpha: 1.0)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        
        let selectedToDo = toDoCDs[indexPath.row]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                for todoCell in toDosFromCoreData {
                    if selectedToDo.priority == 1 {
                        cell.textLabel?.text = "🐼" + selectedToDo.name!
                    } else if selectedToDo.priority == 2 {
                        cell.textLabel?.text = "🐼🐼" + selectedToDo.name!
                    } else {
                        cell.textLabel?.text = selectedToDo.name!
                    }
                }
            }
        }
        if let data = selectedToDo.image {
            cell.imageView?.image = UIImage(data: data)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoCDs[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let selectedToDo = toDoCDs[indexPath.row]
                context.delete(selectedToDo)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getToDos()
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addToDoViewController = segue.destination as? AddToDoViewController {
            addToDoViewController.toDoTableViewController = self
        }
        
        if let detailsToDoViewController = segue.destination as? ToDoDetailsViewController {
            if let selectedToDo = sender as? ToDoCD {
                detailsToDoViewController.toDoCD = selectedToDo
            }
        }
    }
    
}
