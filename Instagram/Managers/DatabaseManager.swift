//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    public func createUser(newUser: User, complition: @escaping (Bool) -> Void){
        let reference = database.document("users/\(newUser.username)")
        guard let data = newUser.asDictionary() else {
            complition(false)
            return
        }
        reference.setData(data) { error in
            complition(error == nil)
        }
    }
    
}
