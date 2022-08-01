//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    let database = Database.database().reference()
    
    //MARK: - PUBLIC
    
    ///Check if username and email is available
    ///- Parameters
    ///     - email string representing email
    ///     - username string representing username 
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        completion(true)
    }
    
    
    ///Insert new user data to database
    ///- Parameters
    ///     - email string representing email
    ///     - username string representing username
    ///     - completion Async call back for result if database entry suceeded
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        let userObject = ["username": username] as [String: Any]
        database.child("\(email.safeDatabaseKey())/profile/").setValue(userObject) { error, _ in
            if error == nil {
                //succeeded
                completion(true)
                return
            }
            else {
               //failed
                completion(false)
                return
            }
        }
    }
}
