//
//  EditInteractor.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//

import Foundation

protocol EditInteractorProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
}

class EditInteractor: EditInteractorProtocol{
    
    var manager: HttpManagerProtocol!
    var response: EditResponseProtocol!
    
    func apiCallContact(id: Int) {
        manager.apiCallContact(id: id) { contact in
            self.response.onCallContact(contact: contact)
        }
    }
    
    func apiEditContact(id: Int, contact: Contact) {
        manager.apiEditContact(id: id, contact: contact) { result in
            self.response.onEditContact(result: result)
        }
    }
}
