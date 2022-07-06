//
//  LoginViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
        
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        //        static let width: CGFloat = frame.size.width - 60
    }
    
    //MARK: - DECLARE UI Elements views for Login screen
    
    private let usernameEmailField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.autocapitalizationType = .none
        field.setLeftPaddingPoints(10)
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .done
        field.autocapitalizationType = .none
        field.setLeftPaddingPoints(10)
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("New user? Create an Account", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Terms of Services", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        
        let header = UIView()
        header.clipsToBounds = true //makes the subview(background image) to be clipped to the header bounds 
        let backgroundImage = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImage)
        return header
    }()
    
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addSubviews(headerView,usernameEmailField, passwordField, loginButton, createAccountButton, forgotPasswordButton, termsButton, privacyButton)
        
        //MARK: - BUTTONS
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //MARK: - ASSIGN FRAMES
        
        headerView.frame = CGRect(x: 0, y: -2, width: view.width, height: view.height/3)
        
        usernameEmailField.frame = CGRect(x: 30, y: headerView.bottom + 40, width: view.width - 60, height: 52)
        
        passwordField.frame = CGRect(x: 30, y: usernameEmailField.bottom + 15, width: view.width - 60, height: 52)
        
        loginButton.frame = CGRect(x: 30, y: passwordField.bottom + 15, width: view.width - 60, height: 52)
        
        createAccountButton.frame = CGRect(x:90, y: loginButton.bottom + 15, width: view.width - 180, height: 52)
        
        forgotPasswordButton.frame = CGRect(x: 140, y: createAccountButton.bottom + 20, width: view.width - 60, height: 52)
        
        termsButton.frame = CGRect(x: 120, y: view.height - view.safeAreaInsets.bottom - 100, width: view.width - 240, height: 50)
        
        privacyButton.frame = CGRect(x: 150, y: view.height - view.safeAreaInsets.bottom - 50, width: view.width - 300, height: 50)
        
        configueHeaderView()
    }
    
    private func configueHeaderView() {
        //check that HeaderViewonly has one subview i.e backgroundImage
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //Add Instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubviews(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
        
    }
    
    // MARK: - BUTTON SELECTORS
    //functions called when buttons are tapped
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        
        sender.showAnimation {
            
            //use [weak self] in the closure to make reference to class weak
            [weak self] in self?.usernameEmailField.resignFirstResponder()
            
            // self becomes optional. self could be nil any time due to the weak reference.
            guard let self = self else { return } // make sure self is not nil by optional binding
            self.passwordField.resignFirstResponder()
        }
        
        // check that email and password field are entered
        guard let usernameEmail = self.usernameEmailField.text, !usernameEmail.isEmpty,
              let password = self.passwordField.text, !password.isEmpty, password.count >= 8 else {
                  return
              }
        //login functionality
        var username: String?
        var email: String?
        
        // check if username or email entered
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        }
        else {
            // username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                    
                }
                else {
                    // error logging in
                    let alert = UIAlertController(title: "Login Error", message: "Unable to log in", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                    print("error")
                }
            }
        }
    }
    @objc private func didTapCreateAccountButton() {
        print("Create Account Button tapped")
        
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        print("Forgot Password tapped")
        
    }
    
    @objc private func didTapTermsButton() {
        
        let urlString = "https://help.instagram.com/581066165581870"
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        
        let urlString = "https://help.instagram.com/519522125107875/?helpref=hc_fnav"
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

//MARK: - EXTENSION

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton(loginButton)
        }
        
        return true
    }
}
