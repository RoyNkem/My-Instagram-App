//
//  LoginViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // DECLARE UI Elements views for Login screen
    private let usernameEmailField: UITextField = {
        
        return UITextField()
    }()
    
    private let passwordField: UITextField = {
        
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        
        return UIButton()
    }()
    
    private let termsButton: UIButton = {
        
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        
        return UIButton()
    }()
    
    private let headerView: UIView = {
        
        return UIButton()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(usernameEmailField, passwordField, loginButton, createAccountButton, termsButton, privacyButton)
        
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //assign Frames
    }    
    
    // MARK: - BUTTONS
    
    
    
    // MARK: - SELECTORS
    //functions called when buttons are tapped
    
    @objc private func didTapLoginButton() {
        print("Login Button tapped")
    }
    
    @objc private func didTapCreateAccountButton() {
        print("Create Account Button tapped")
    }
    
    @objc private func didTapTermsButton() {
        print("Terms Button tapped")
    }
    
    @objc private func didTapPrivacyButton() {
        print("Privacy Button tapped")
    }
    
}
