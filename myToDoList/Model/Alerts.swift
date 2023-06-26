import UIKit

protocol AlertsDelegate {
    func showAlertIfNameIsEmpty()
}

struct Alerts {
    
    var delegate: AlertsDelegate?
    
    func showAlertIfNameIsEmpty() {
        let alert = UIAlertController(title: "Enter ToDo name.", message: "Every ToDo needs a name.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Every ToDo needs a name."), style: .default, handler: {_ in
        }))
        
        alert.present(alert, animated: true, completion: nil)
    }
    
}
