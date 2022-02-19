//
//  CreateViewController.swift
//  PDP_StoryboardContact
//


import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
}

protocol CreateResponseProtocol {
    func onContactCreate(isCreated: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol {
    
    @IBOutlet weak var mainBackgroundView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var saveBtnView: UIButton!
    
    var singleContact: Contact!
    
    var presenter: CreateRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        configureViper()
    }
    
    func configureViper(){
            let manager = HttpManager()
            let presenter = CreatePresenter()
            let interactor = CreateInteractor()
            let routing = CreateRouting()
            
            presenter.controller = self
            
            self.presenter = presenter
            presenter.interactor = interactor
            presenter.routing = routing
            routing.viewController = self
            interactor.manager = manager
            interactor.response = self
        }


    // MARK: - Methods...

    private func initViews() {
        
        title = "New Contact"
        
        mainBackgroundView.layer.cornerRadius = 18.0
        
        saveBtnView.layer.masksToBounds = true
        saveBtnView.layer.cornerRadius = 18.0
        
    }
    
    func createContact(contact: Contact) {
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsContactCreate(contact: contact), handler: { response in
            switch response.result {
                case .success:
                    print("done")
                case let .failure(error):
                    print(error.localizedDescription)
            }
            
        })
    }
    
    func onContactCreate(isCreated: Bool) {
            if isCreated {
                self.navigationController?.popViewController(animated: true)
            }else{
                
            }
        }
    
    // MARK: - Actions...
    @IBAction func saveBtnAction(_ sender: Any) {
        singleContact = Contact(name: nameTextField.text!, number: phoneNumberTextField.text!)
        createContact(contact: singleContact)
        self.navigationController?.popViewController(animated: true)
    }
    
}
