//
//  EditPresenter.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//


import Foundation

protocol EditPresenterProtocol: EditRequestProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
    
}

class EditPresenter: EditPresenterProtocol{
    
    var interactor: EditInteractorProtocol!
    var routing: EditRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiCallContact(id: Int) {
        controller.indicateProgressView()
        interactor.apiCallContact(id: id)
    }
    
    func apiEditContact(id: Int, contact: Contact) {
        controller.indicateProgressView()
        interactor.apiEditContact(id: id, contact: contact)
    }
    
}
