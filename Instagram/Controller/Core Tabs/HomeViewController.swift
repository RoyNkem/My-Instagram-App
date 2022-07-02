//
//  HomeViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("error")
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Home")
        
        handleNotAuthenticated()
    }
    
    func handleNotAuthenticated() {
        //Check Auth status
        if Auth.auth().currentUser == nil {
            // show loginVC
            let loginVC = LoginViewController()
            
            loginVC.modalPresentationStyle = .fullScreen
            
            present(loginVC, animated: false)
        }
    }
}
