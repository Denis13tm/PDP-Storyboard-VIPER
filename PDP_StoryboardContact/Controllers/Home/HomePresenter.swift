//
//  HomePresenter.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//

import Foundation

protocol HomePresenterProtocol: HomeRequestProtocol {
    func apiContactList()
    func apiContactDelete(contact: Contact)
    
    func navigateCreateScreen()
    func navigateEditScreen(id: String)
}

class HomePresenter: HomePresenterProtocol{
    
    var interactor: HomeInteractorProtocol!
    var routing: HomeRoutingProtocol!
    
    var controller: BaseViewController!
    
    func apiContactList() {
        controller.indicateProgressView()
        interactor.apiContactList()
    }
    
    func apiContactDelete(contact: Contact) {
        controller.indicateProgressView()
        interactor.apiContactDelete(contact: contact)
    }
    
    func navigateCreateScreen() {
        routing.navigateCreateScreen()
    }
    
    func navigateEditScreen(id: String) {
        routing.navigateEditScreen(id: id)
    }
    
}
