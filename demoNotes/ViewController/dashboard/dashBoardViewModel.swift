//
//  dashBoardViewModel.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import Foundation

class dashBoardViewModel: BaseViewM {
    
    var arrUsers = [UsersModel]()
    
    func getUsersCollection(completionHandeler: @escaping ((_ success: Bool, _ message: String)->())) {
        db.collection(FirestoreTableInfo.notes).getDocuments() { (querySnapshot, err) in
            if let err
                = err {
                print("Error getting documents: \(err)")
                completionHandeler(false, err.localizedDescription)
            }
            else {
                guard let usersJson = querySnapshot?.documents else{
                    return
                }
                
                self.arrUsers.removeAll()
                for user in usersJson {
                    let user = UsersModel(json: user.data(), documentId: user.documentID)
                    self.arrUsers.append(user)
                }
                completionHandeler(true, "get users successfully")

            }
        }
    }
    
}
