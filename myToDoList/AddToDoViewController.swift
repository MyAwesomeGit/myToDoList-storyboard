import UIKit

class AddToDoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var toDoTableViewController: ToDoTableViewController?=nil
    
    var pickerController = UIImagePickerController()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func mediaFolderTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if nameTextField.text == "" {
            showAlertIfNameIsEmpty()
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let newToDo = ToDoCD(context: context)
                if let name = nameTextField.text {
                    newToDo.name = name
                    newToDo.priority = Int32(prioritySegment.selectedSegmentIndex)
                    newToDo.image = imageView.image?.jpegData(compressionQuality: 1.0)
                    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                }
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 222/256, green: 220/256, blue: 217/256, alpha: 1.0)]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        nameTextField.delegate = self
        textFieldShouldReturn(nameTextField)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    
    func showAlertIfNameIsEmpty() {
        let alert = UIAlertController(title: "Enter ToDo name.", message: "Every ToDo needs a name.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Every ToDo needs a name."), style: .default, handler: {_ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
