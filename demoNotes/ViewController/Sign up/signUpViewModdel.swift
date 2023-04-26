//
//  signUpViewModdel.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation
import Firebase


class signUpVM : BaseViewM {
    var name : String = ""
    var email : String = ""
    var password: String = ""
    var title : String = ""
    var content : String = ""
    
    
    func signupAuth(completionHandeler: @escaping ((_ success: Bool, _ message: String)->()) ) {

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode.Code(rawValue: error.code) {
                case .operationNotAllowed:
                    completionHandeler(false, "operationNotAllowed")
                    DLog("operationNotAllowed")
                    break
                case .emailAlreadyInUse:
                    completionHandeler(false, "emailAlreadyInUse")
                    DLog("emailAlreadyInUse")
                    break
                case .invalidEmail:
                    completionHandeler(false, "invalidEmail")
                    DLog("invalidEmail")
                    break
                case .weakPassword:
                    completionHandeler(false, "weakPassword")
                    DLog("weakPassword")
                    break
                default:
                    DLog("Error: \(error.localizedDescription)")
                    completionHandeler(false, error.localizedDescription)
                }
            } else {
                DLog("User signs up successfully")
                self.storeLoginData(completionHandler: completionHandeler)
            }
        }
    }

    private func storeLoginData(completionHandler: @escaping((_ success: Bool, _ message: String)->())) {
        var ref: DocumentReference? = nil
        ref = db.collection(FirestoreTableInfo.notes).addDocument(data: [
            "name": name,
            "email": email,
            "password": password,
            "title": title,
            "content ": content
        ]){error in
            
        if let error = error {
            completionHandler(false, error.localizedDescription)
            DLog("Error adding document: \(error)")
        }
        else {
            completionHandler(true, "Useer signs up successfully")
            DLog("Document added with ID: \(ref!.documentID)")
        }
    }
}
}
