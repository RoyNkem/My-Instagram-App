//
//  AuthManager.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                // - Create account
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard error == nil, authResult != nil else {
                        //firebase auth could not create account with username or email
                        completion(false)
                        return
                    }
                    //error is nil, firebase auth can create account:
                    //- Insert account to database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            // failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // username or email already exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) { // login with username or email
        
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false) // we used completion inside of a closure, so the scope needs to "escape"
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }
}
