//
//  ForgotPasswordViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/08/2022.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    //MARK: - DECLARE UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "blacktextlogo")
        return imageView
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your username or email to reset password"
        label.textColor = .link
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.keyboardType = .emailAddress
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
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset My password", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameEmailField.delegate = self
        view.backgroundColor = .secondarySystemBackground
        view.addSubviews(logoImageView, instructionLabel, usernameEmailField, resetButton)
        
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    //MARK: - Tap Reset button
    @objc private func didTapResetButton(_ sender: UIButton) {
        //reset password
        var username: String?
        var email: String?
        
        sender.showAnimation {// animate button tap
            
            //use [weak self] in the closure to make reference to class weak
            [weak self] in self?.usernameEmailField.resignFirstResponder()
        }
        // check that email and password field are entered
        guard let usernameEmail = self.usernameEmailField.text else {
            return
        }
        
        //MARK: - ...textfield animations
        if usernameEmail.isEmpty {
            usernameEmailField.animateInvalidLogin() //shake animations
            usernameEmailField.layer.borderColor = UIColor.red.cgColor //red warning
            usernameEmailField.layer.borderWidth = 1
            
        } else {
            usernameEmailField.layer.borderColor = UIColor.clear.cgColor
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
        
        guard let email = email else { return }
        //MARK: - ...Send password link
        AuthManager.shared.resetPassword(email: email, onSuccess: {
            self.view.endEditing(true)
            "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password"
            self.navigationController?.popViewController(animated: true)
        }, onError: { (errorMessage) in
            "Error Reseting password. Please try again"
            
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //MARK: - ASSIGN FRAMES
        logoImageView.frame = CGRect(x: 40, y: 20, width: view.width - 80, height: 60)
        
        instructionLabel.frame = CGRect(x: 40, y: logoImageView.bottom + 20, width: view.width - 80, height: 40)
        
        usernameEmailField.frame = CGRect(x: 30, y: instructionLabel.bottom + 20, width: view.width - 60, height: 52)
        
        resetButton.frame = CGRect(x: 30, y: usernameEmailField.bottom + 30, width: view.width - 60, height: 52)
        
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
}
