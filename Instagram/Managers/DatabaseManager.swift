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
    
}
