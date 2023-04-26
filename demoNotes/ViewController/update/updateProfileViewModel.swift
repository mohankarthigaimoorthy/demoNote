//
//  updateProfileViewModel.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation

class UpdateProfileVM : BaseViewM {
    var userInfo: UsersModel!
    
    func updateUserProfileDocument(completionHandeler: @escaping ((_ success: Bool, _ message: String)->())) {
   
        let washingtonRef = db.collection(FirestoreTableInfo.notes).document(userInfo.documentId)

        washingtonRef.updateData([
            "name": userInfo.name,
            "email": userInfo.email,
            "password": userInfo.password,
            "title": userInfo.title,
            "content": userInfo.content
        ])
        {
            err in
            if let err = err {
                completionHandeler(false, err.localizedDescription)
                DLog("Error updating document: \(err)")
            } else {
                completionHandeler(true, "Document successfully updated")
                DLog("Document successfully updated")
            
            }
        }
    }
    
}
