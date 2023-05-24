//
//  ViewController.swift
//  ChatApp
//
//  Created by Damir Zaripov on 22.05.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: - Elements
    private let emailInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.text = "1@2.com"
        textField.backgroundColor = .white
        textField.textColor = UIColor(named: "BrandBlue")
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 25)
        textField.minimumFontSize = 17
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.white.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "123456"
        textField.backgroundColor = .white
        textField.textColor = UIColor(named: "BrandBlue")
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 25)
        textField.minimumFontSize = 17
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.white.cgColor
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BrandBlue")
        setLayout()
        setConstraints()
    }
    
    private func setLayout() {
        view.addSubview(emailInput)
        view.addSubview(passwordInput)
        view.addSubview(loginButton)
    }
    
    
    private func setConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            emailInput.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            emailInput.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            emailInput.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 30),
            passwordInput.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            passwordInput.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            
            loginButton.topAnchor.constraint(equalTo:passwordInput.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            
            
        ])
    }
    
    
    @objc private func loginPressed() {
        
        if let email = emailInput.text, let password = passwordInput.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let vc = ChatViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
    
    
}
