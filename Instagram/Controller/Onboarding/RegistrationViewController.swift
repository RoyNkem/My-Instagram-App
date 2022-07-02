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
    
    //MARK: - BUTTON SELECTOR
    @objc func didTapSignupButton(_ sender: UIButton) {
        
        sender.showAnimation{
            
            //use [weak self] in the closure to make reference to class weak
            [weak self] in self?.usernameField.resignFirstResponder()
            // self becomes optional self could be nil any time due to the weak reference.
            guard let self = self else { return }
            self.passwordField.resignFirstResponder()
            self.emailField.resignFirstResponder()
            
            // check that field are not empty
            guard let email = self.emailField.text, !email.isEmpty,
                  let password = self.passwordField.text, !password.isEmpty, password.count >= 8,
                  let username = self.usernameField.text, !username.isEmpty else {
                      return
                  }
            
            //register the new user on button tap
            AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
                DispatchQueue.main.async {
                    if registered {
                        // good to go
                    }
                    else {
                        //                    let alert = UIAlertController(title: "Registration Error", message: "Unable to register user", preferredStyle: .alert)
                        //                    let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                        //
                        //                    alert.addAction(action)
                        //                    self.present(alert, animated: true)
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
