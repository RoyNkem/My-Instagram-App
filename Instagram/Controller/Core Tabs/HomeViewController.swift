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
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    func handleNotAuthenticated() {
        //Check Auth status
        if Auth.auth().currentUser == nil {
            // show login
            let loginVC = LoginViewController()
            
            loginVC.modalPresentationStyle = .fullScreen
            
            present(loginVC, animated: false)
        }
    }
    
}
