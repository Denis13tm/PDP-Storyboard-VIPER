//
//  HomeViewViewController.swift
//  PDP_StoryboardContact
//


import UIKit

protocol HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(id: String)
}

protocol HomeResponseProtocol {
    func onContactList(contact: [Contact])
    func onContactDelete(isDeleted: Bool)
}

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, HomeResponseProtocol {

    @IBOutlet weak var tableView: UITableView!
    var contactList: Array<Contact> = Array()
    
    var presenter: HomeRequestProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getContactList()
        tableView.reloadData()
    }


    // MARK: - Methods...
    
    private func initViews() {
        initNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getContactList()
    }
    
    func configureViper(){
            let manager = HttpManager()
            let presenter = HomePresenter()
            let interactor = HomeInteractor()
            let routing = HomeRouting()
            
            presenter.controller = self
            
            self.presenter = presenter
            presenter.interactor = interactor
            presenter.routing = routing
            routing.viewController = self
            interactor.manager = manager
            interactor.response = self
        }
    
    func onContactList(contact: [Contact]) {
            self.hideProgressView()
            self.refreshTableView(contacts: contact)
        }
        
        func onContactDelete(isDeleted: Bool) {
            self.hideProgressView()
            presenter.apiContactList()
        }
    
    func callCreateViewController(){
            let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    func callEditViewController(id: String){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.contactID = id
        let navigationController = UINavigationController(rootViewController: vc)
        print(vc.contactID)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    //Call APIs...
    public func getContactList() {
        indicateProgressView()
    }
    
    private func deleteContact(contact: Contact) {
        indicateProgressView()
    }
    
    private func refreshTableView(contacts: [Contact]) {
        self.contactList = contacts
        self.tableView.reloadData()
    }

    private func initNavBar() {
        title = "Storyboard MVC"
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "text.badge.plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }
    
    func onContactCreate(isCreated: Bool) {
            if isCreated {
                self.navigationController?.popViewController(animated: true)
            }else{
                
            }
        }
    
    //MARK: - Actions...
    
    @objc func leftTapped() {
        getContactList()
    }
    @objc func rightTapped() {
        
    }
   
    //MARK: - Table View Methods...
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleContact = contactList[indexPath.row]
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)? .first as! ContactTableViewCell
        
        cell.titleLabel.text = singleContact.name
        cell.bodyLabel.text = singleContact.number
        
        return cell
    }
    
    //new ones to me.. and repractice them :)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, contact: contactList[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, contact: contactList[indexPath.row])])
    }
    
    //MARK: - Contextual Actions...
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE :(")
            completion(true)
            self.deleteContact(contact: contact)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            completion(true)
            print("COMPLETE :)")
        }
    }
    
    
}
