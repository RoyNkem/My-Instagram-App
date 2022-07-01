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
    
    public func registerUser(username: String, email: String, password: String) {
      /*
       - Check if username is available
       - Check if email is available
       - Create account
       - Insert account to database
       */
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
