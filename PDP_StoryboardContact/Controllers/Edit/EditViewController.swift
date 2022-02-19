//
//  EditViewController.swift
//  PDP_StoryboardContact
//


import UIKit

protocol EditRequestProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
}

protocol EditResponseProtocol {
    func onCallContact(contact: Contact)
    func onEditContact(result: Bool)
}


class EditViewController: BaseViewController, EditResponseProtocol {
    
    var presenter: EditRequestProtocol!
    
    @IBOutlet weak var lowestBackgroundView: UIView!
    @IBOutlet weak var middleBackgroundView: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var titleUpperBackgroundView: UIView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var saveBtnView: UIButton!
    
    var singleContact: Contact!
    var id: String?
    var name: String?
    var phoneNumber: String?
    
    typealias completion = (Bool)->Void
    var editCompletion:completion!
    
    
    var contactID: String = "1"
    var info : Contact = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        hideKeyboardWhenTappedAround()
    }

    
    func configureViper(){
           let manager = HttpManager()
           let presenter = EditPresenter()
           let interactor = EditInteractor()
           let routing = EditRouting()
           
           presenter.controller = self
           
           self.presenter = presenter
           presenter.interactor = interactor
           presenter.routing = routing
           routing.viewController = self
           interactor.manager = manager
           interactor.response = self
       }
    
    
    func onCallContact(contact: Contact) {
            self.hideProgressView()
            info = contact
            initViews()
        }
        
        func onEditContact(result: Bool) {
            self.hideProgressView()
            if result {
                self.dismiss(animated: true, completion: nil)
            }else{
                
            }
        }

    // MARK: - Methods...

    private func initViews() {
        saveBtnView.layer.masksToBounds = true
        saveBtnView.layer.cornerRadius = 18.0
        
        titleBackgroundView.layer.cornerRadius = 18.0
        titleUpperBackgroundView.layer.cornerRadius = 18.0
        
        lowestBackgroundView.layer.cornerRadius = 18.0
        middleBackgroundView.layer.cornerRadius = 18.0
        mainBackgroundView.layer.cornerRadius = 18.0
        
        nameTextField.text = name
        phoneNumberTextField.text = phoneNumber
        
    }
    
    private func editContact(contact: Contact) {
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + id!, params: AFHttp.paramsContactUpdate(contact: singleContact), handler: { response in
            switch response.result {
                case .success:
                    self.editCompletion(true)
                case let .failure(error):
                    print(error.localizedDescription)
            }
        })
    }
    

    //MARK: - Actions...
    
    @IBAction func saveBtnAction(_ sender: Any) {
        singleContact = Contact(name: nameTextField.text!, number: phoneNumberTextField.text!)
        editContact(contact: singleContact)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



// Put this piece of code anywhere you like to hide default keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

