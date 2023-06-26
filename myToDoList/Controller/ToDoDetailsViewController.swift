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
        let alert = UIAlertController(title: "Attention.", message: "To Do's done and will be removed from To Do List.", preferredStyle: .alert)
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
                    editName.text = "🐼" + name
                    if let data = toDo.image {
                        imageViewDetails.image = UIImage(data: data)
                    }
                }
            }
            else if toDo.priority == 2 {
                if let name = toDo.name {
                    editName.text = "🐼🐼" + name
                    if let data = toDo.image {
                        imageViewDetails.image = UIImage(data: data)
                    }
                }
            }
            else {
                if let name = toDo.name {
                    editName.text = name
                    if let data = toDo.image {
                        imageViewDetails.image = UIImage(data: data)
                    }
                }
                if let data = toDo.image {
                    imageViewDetails?.image = UIImage(data: data)
                }
            }
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        editName.delegate = self
        textFieldShouldReturn(editName)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
