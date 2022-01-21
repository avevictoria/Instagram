//
//  StorageManager.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    let storage = Storage.storage()
    
}
