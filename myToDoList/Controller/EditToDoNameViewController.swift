import UIKit

class EditToDoNameViewController: UIViewController {
    
    var toDoCD: ToDoCD? = nil
    
    @IBOutlet weak var editToDoName: UITextField!
    
    @IBAction func editToDoNameButton(_ sender: Any) {
        if editToDoName.text == "" {
//                    showAlertIfNameIsEmpty()
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                if let editableToDo = self.toDoCD {
                    
                    editableToDo.name = editToDoName.text
                    try? context.save()
                    
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                    self.navigationController?.popViewController(animated: true)
                }
                self.navigationController?.popViewController(animated: true)
            }
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
}
