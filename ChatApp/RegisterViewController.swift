//
//  ViewController.swift
//  ChatApp
//
//  Created by Damir Zaripov on 22.05.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    //MARK: - Elements
    private let emailInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.textColor = UIColor(named: "BrandBlue")
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 25)
        textField.minimumFontSize = 17
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = UIColor(named: "BrandBlue")
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 25)
        textField.minimumFontSize = 17
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        return button
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BrandLightBlue")
        setLayout()
        setConstraints()
    }
    
    private func setLayout() {
        view.addSubview(emailInput)
        view.addSubview(passwordInput)
        view.addSubview(registerButton)
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
            
            registerButton.topAnchor.constraint(equalTo:passwordInput.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 48),


            
        ])
    }

    @objc private func registerPressed() {

        if let email = emailInput.text, let password = passwordInput.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let vc = ChatViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

