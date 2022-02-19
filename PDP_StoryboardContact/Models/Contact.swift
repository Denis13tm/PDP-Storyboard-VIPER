//
//  Post.swift
//  PDP_StoryboardContact
//

import Foundation

struct Contact: Decodable{
    var id: String? = ""
    var name: String? = ""
    var number: String? = ""
    
    init(){
    }
    
    init(name: String, number: String){
        self.name = name
        self.number = number
    }
}
