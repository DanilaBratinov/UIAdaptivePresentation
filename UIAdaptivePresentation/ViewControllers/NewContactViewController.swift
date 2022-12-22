import UIKit

protocol NewContactViewControllerDelegate {
    func saveContact(_ contact: Contact)
}

class NewContactViewController: UIViewController {

    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentationController?.delegate = self
                
        firstNameTextField.addTarget(
            self,
            action: #selector(firstNameTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        saveAndExit()
    }
    
    @IBAction func canceButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc private func firstNameTextFieldDidChanged() {
        guard let firstName = firstNameTextField.text else { return }
        doneButton.isEnabled = !firstName.isEmpty ? true : false
        isModalInPresentation = !firstName.isEmpty ? true : false
    }
    
    private func saveAndExit() {
        guard let firstName = firstNameTextField.text else { return }
        guard let lastName = lastNameTextField.text else { return }
        
        let contact = Contact(name: firstName, surname: lastName)
        
        StorageManager.shared.save(contact: contact)
        
        delegate.saveContact(contact)
        dismiss(animated: true)
    }
    
    private func showAlertSheet() {
        let alertSheet = UIAlertController(
            title: "Выберите действие",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let saveAction = UIAlertAction(title: "Сохранить контакт", style: .default) { _ in
            self.saveAndExit()
        }
        let deleteContact = UIAlertAction(title: "Не сохранять контакт", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertSheet.addAction(saveAction)
        alertSheet.addAction(deleteContact)
        alertSheet.addAction(cancelAction)
        
        present(alertSheet, animated: true)
    }
}

extension NewContactViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        showAlertSheet()
    }
}
