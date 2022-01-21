//
//  AuthManager.swift
//  Instagram
//
//  Created by Victoria Nosik on 20.01.2022.
//
import FirebaseAuth
import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(
        email: String,
        password:String,
        completion: (Result<User, Error>) -> Void
    ) {
        
    }
    
    public func signUp(
        email: String,
        username: String,
        password: String,
        profilePicture: Data?,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        
    }
    
    public func signOut(completion: @escaping(Bool) -> Void) {
        
    }
    
    
}
