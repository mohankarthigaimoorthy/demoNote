//
//  userModel.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation

class UsersModel {
    
    var documentId = ""
    var name = ""
    var email = ""
    var password = ""
    var title = ""
    var content = ""
    
    init() {  }
        
        init(json: [String: Any], documentId: String = "") {
            self.documentId = documentId
            name = json["name"] as? String ?? ""
            email = json["email"] as? String ?? ""
            password = json["password"] as? String ?? ""
            title = json["title"] as? String ?? ""
       content = json["content"] as? String ?? ""
    }
}
