import UIKit

class ToDoDetailsViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var toDoCD: ToDoCD? = nil
    
    @IBOutlet weak var imageViewDetails: UIImageView!
    
    @IBAction func doneTapped(_ sender: Any) {
        removeItemFromToDoList()
    }
    
    @IBOutlet weak var editName: UITextField!
    
    @IBAction func editToDoNameTapped(_ sender: Any) {
        if editName.text == "" {
            editName.text = "Enter ToDo name."
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.self {
                    if let toDo = self.toDoCD {
                        toDo.name = editName.text
                        toDo.priority = 0
                    }
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
    }
    
    
    func removeItemFromToDoList() {
        let alert = UIAlertController(title: "Attention.", message: "ToDo completed and will be removed from To Do List.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "ToDo completed and will be removed from To Do List."), style: .default, handler: {_ in
            
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
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                    for todoCell in toDosFromCoreData {
                        if toDo.priority == 1 {
                            editName.text = "🐼" + toDo.name!
                        } else if toDo.priority == 2 {
                            editName.text = "🐼🐼" + toDo.name!
                        } else {
                            editName.text = toDo.name!
                        }
                    }
                }
            }
            if let data = toDo.image {
                imageViewDetails.image = UIImage(data: data)
            }
        }
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        editName.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
