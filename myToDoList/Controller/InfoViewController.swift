import UIKit

class InfoViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBAction func deleteAllToDos(_ sender: Any) {
        checkToDos()
    }
    
    
    func checkToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                if let toDos = toDosFromCoreData as? [ToDoCD] {
                    if toDos == [] {
                        nothingToDeleteNotification()
                    } else {
                        alertBeforeDeleting()
                    }
                }
            }
        }
    }
    
    
    func alertBeforeDeleting() {
        let alert = UIAlertController(title: "Attention.", message: "Do you really want to permanently delete all ToDos?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Do you really want to permanently delete all ToDos?"), style: .destructive, handler: {_ in
            self.deleteAllToDos()
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Action canceled"), style: .default, handler: {_ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func deleteAllToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                for toDos in toDosFromCoreData {
                    context.delete(toDos)
                }
            }
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("An Error Occured: \(error)")
            }
        }
        notificationOfSuccessfulDeletion()
    }
    
    
    func notificationOfSuccessfulDeletion() {
        let alert = UIAlertController(title: "Done.", message: "All ToDos were succesfully deleted.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "All ToDos were succesfully deleted."), style: .default, handler: {_ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func nothingToDeleteNotification() {
        let alert = UIAlertController(title: "Nothing to delete.", message: "All ToDos were deleted already.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "All ToDos were deleted already."), style: .default, handler: {_ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
    
