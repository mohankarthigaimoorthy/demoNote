//
//  loginViewModel.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation
import Firebase

class LoginVM: BaseViewM {
 
    var email : String = ""
    var password: String = ""
    
    func loginAuth(completionHandler: @escaping ((_ success: Bool, _ message: String) -> ()))
    {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            HideLoaderOnView()
            if let error = error as NSError? {
                switch AuthErrorCode.Code(rawValue: error.code) {
                case .operationNotAllowed:
                    DLog("operationNotAllowed")
                    completionHandler(false,"operationNotAllowed")
                    break
               case .userDisabled:
                    DLog("userDisabled")
                    completionHandler(false,"userDisabled")
                    break
                         
               case .wrongPassword:
                    DLog("wrongPassword")
                    completionHandler(false, "wrongPasswore")
                    break
               case .invalidEmail:
                    DLog("invalidEmail")
                    completionHandler(false,"invalidEmail")
                    break
                         default :
                            completionHandler(false, "invalideEmail")
                         DLog("Error: \(error.localizedDescription)")
                         }
            }
                         else {
                        DLog("User login successfully")
                        completionHandler(true,"User Login successfully")
                    }
        }
    }
}
