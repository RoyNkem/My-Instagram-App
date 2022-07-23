//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
        //        static let width: CGFloat = frame.size.width - 60
    }
    
    //MARK: - DECLARE UI Elements views for Login screen
    
    private let usernameField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Username"
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
    
    private let emailField: UITextField = {
        
        let field = UITextField()
        field.placeholder = "Email"
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
    
    private let signupButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubviews(usernameField, emailField, passwordField, signupButton)
        view.backgroundColor = .systemBackground
        
        //Button action
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //MARK: - ASSIGN FRAMES
        
        usernameField.frame = CGRect(x: 30, y: view.safeAreaInsets.top + 100, width: view.width - 60, height: 52)
        
        emailField.frame = CGRect(x: 30, y: usernameField.bottom + 15, width: view.width - 60, height: 52)
        
        passwordField.frame = CGRect(x: 30, y: emailField.bottom + 15, width: view.width - 60, height: 52)
        
        signupButton.frame = CGRect(x: 30, y: passwordField.bottom + 45, width: view.width - 60, height: 52)
    }
    
    //MARK: - TAP Signup Button
    @objc func didTapSignupButton(_ sender: UIButton) {
        
        sender.showAnimation{
            
            //use [weak self] in the closure to make reference to class weak
            [weak self] in self?.usernameField.resignFirstResponder()
            // self becomes optional self could be nil any time due to the weak reference.
            guard let self = self else { return }
            self.passwordField.resignFirstResponder()
            self.emailField.resignFirstResponder()
            
            guard let email = self.emailField.text,
                  let password = self.passwordField.text,
                  let username = self.usernameField.text
            else {
                return
            }
            
            //MARK: - ...textfield animations
            if email.isEmpty && password.isEmpty && username.isEmpty {
                self.emailField.animateInvalidLogin() //shake animation
                self.passwordField.animateInvalidLogin()
                self.usernameField.animateInvalidLogin()
                
                self.usernameField.layer.borderColor = UIColor.red.cgColor //red warning
                self.usernameField.layer.borderWidth = 1
                
                self.emailField.layer.borderColor = UIColor.red.cgColor
                self.emailField.layer.borderWidth = 1
                
                self.passwordField.layer.borderColor = UIColor.red.cgColor
                self.passwordField.layer.borderWidth = 1
                
            } else if email.isEmpty {
                self.emailField.animateInvalidLogin()
                self.emailField.layer.borderColor = UIColor.red.cgColor
                self.emailField.layer.borderWidth = 1
                
                self.usernameField.layer.borderColor = UIColor.clear.cgColor
                self.passwordField.layer.borderColor = UIColor.clear.cgColor

            } else if password.isEmpty || password.count < 6 {
                self.passwordField.animateInvalidLogin()
                self.passwordField.layer.borderColor = UIColor.red.cgColor
                self.passwordField.layer.borderWidth = 1
                
                self.usernameField.layer.borderColor = UIColor.clear.cgColor
                self.emailField.layer.borderColor = UIColor.clear.cgColor
                
            } else if username.isEmpty {
                self.usernameField.animateInvalidLogin()
                self.usernameField.layer.borderColor = UIColor.red.cgColor
                self.usernameField.layer.borderWidth = 1
                
                self.emailField.layer.borderColor = UIColor.clear.cgColor
                self.passwordField.layer.borderColor = UIColor.clear.cgColor
                
            } else {
                self.usernameField.layer.borderColor = UIColor.clear.cgColor
                self.emailField.layer.borderColor = UIColor.clear.cgColor
                self.passwordField.layer.borderColor = UIColor.clear.cgColor
            }
            
            //MARK: - ...Sign up
            AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
                DispatchQueue.main.async {
                    if  password.count >= 6 && registered {
                        // good to go
                    }
                    else if !email.isEmpty && !password.isEmpty && password.count >= 8 && !username.isEmpty {
                        let alert = UIAlertController(title: "Registration Error", message: "Unable to register at the moment. Please try to login", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapSignupButton(signupButton)
        }
        return true
    }
}
