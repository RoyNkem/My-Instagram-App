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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField.text!.isEmpty) {
            // change textfield border color
            usernameEmailField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderColor = UIColor.red.cgColor
        } else {
            // remove text field border or change color
            return
        }
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
        //check that HeaderView only has one subview i.e backgroundImage
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //Add Instagram logo
        let instagramImage = UIImageView(image: UIImage(named: "text"))
        headerView.addSubviews(instagramImage)
        instagramImage.contentMode = .scaleAspectFit
        instagramImage.frame = CGRect(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
        
    }
    
    // MARK: - TAP Login Button
    @objc private func didTapLoginButton(_ sender: UIButton) {
       
        //login functionality
        var username: String?
        var email: String?
        
        sender.showAnimation {// animate button tap
            
            //use [weak self] in the closure to make reference to class weak
            [weak self] in self?.usernameEmailField.resignFirstResponder()
            
            // self becomes optional. self could be nil any time due to the weak reference.
            guard let self = self else { return } // make sure self is not nil by optional binding
            self.passwordField.resignFirstResponder()
        }
        
        // check that email and password field are entered
        guard let usernameEmail = self.usernameEmailField.text,
              let password = self.passwordField.text else {
            return
        }
        
        //MARK: - ...textfield animations
        if usernameEmail.isEmpty && password.isEmpty {
            usernameEmailField.animateInvalidLogin() //shake animations
            passwordField.animateInvalidLogin()
            
            usernameEmailField.layer.borderColor = UIColor.red.cgColor //red warning
            usernameEmailField.layer.borderWidth = 1
            
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 1
            
        } else if usernameEmail.isEmpty {
            usernameEmailField.animateInvalidLogin()
            usernameEmailField.layer.borderColor = UIColor.red.cgColor
            usernameEmailField.layer.borderWidth = 1
            
            passwordField.layer.borderColor = UIColor.clear.cgColor

        } else if password.isEmpty || password.count < 6 {
            passwordField.animateInvalidLogin()
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 1
            
            usernameEmailField.layer.borderColor = UIColor.clear.cgColor

        } else {
            usernameEmailField.layer.borderColor = UIColor.clear.cgColor
            passwordField.layer.borderColor = UIColor.clear.cgColor
        }
        
        // check if username or email entered
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            // email
            email = usernameEmail
        }
        else {
            // username
            username = usernameEmail
        }
        
        //MARK: - ...Login
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if password.count >= 6 && success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                    
                }
                else if !usernameEmail.isEmpty && !password.isEmpty && password.count >= 6 {
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
    
    // MARK: - Create Account Button
    @objc private func didTapCreateAccountButton() {
        print("Create Account Button tapped")
        
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    // MARK: - Forgot Password Button
    @objc private func didTapForgotPassword() {
        print("Forgot Password tapped")
        
    }
    
    // MARK: - Terms Button
    @objc private func didTapTermsButton() {
        
        let urlString = "https://help.instagram.com/581066165581870"
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    // MARK: - Privacy Button
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
