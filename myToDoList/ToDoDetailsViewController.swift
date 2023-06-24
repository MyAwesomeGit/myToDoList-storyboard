import UIKit

class ToDoDetailsViewController: UIViewController {
    
    var toDoCD: ToDoCD? = nil
    
    @IBOutlet weak var toDoLabel: UILabel!
    
    @IBOutlet weak var imageViewDetails: UIImageView!
    
    @IBAction func doneTapped(_ sender: Any) {
        removeItemFromToDoList()
    }
    
    func removeItemFromToDoList() {
        let alert = UIAlertController(title: "Attention.", message: "To Do's done and will be removed from To Do List", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "To Do has been removed from To Do List"), style: .default, handler: {_ in
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                if let toDo = self.toDoCD {
                    context.delete(toDo)
                }
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Action canceled"), style: .default, handler: {_ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDo = toDoCD {
            if toDo.priority == 1 {
                if let name = toDo.name {
                    toDoLabel.text = "🐼" + name
                    if let data = toDo.image {
                        imageViewDetails.image = UIImage(data: data)
                    }
                }
            }
            else if toDo.priority == 2 {
                if let name = toDo.name {
                    toDoLabel.text = "🐼🐼" + name
                    
                    if let data = toDo.image {
                        imageViewDetails.image = UIImage(data: data)
                    }
                }
            }
            else {
                if let name = toDo.name {
                    toDoLabel.text = name
                    
                    if let data = toDo.image {
                        imageViewDetails.image = UIImage(data: data)
                    }
                }
                if let data = toDo.image {
                    imageViewDetails?.image = UIImage(data: data)
                }
            }
        }
    }
    
}
