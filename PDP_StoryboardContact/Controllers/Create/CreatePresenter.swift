//
//  CreatePresenter.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//


import Foundation

protocol CreatePresenterProtocol: CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
    
}

class CreatePresenter: CreatePresenterProtocol {
    
    var interactor: CreateInteractorProtocol!
    var routing: CreateRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactCreate(contact: Contact) {
        controller.indicateProgressView()
        interactor.apiContactCreate(contact: contact)
    }
    
}
