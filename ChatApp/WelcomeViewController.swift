//
//  ViewController.swift
//  ChatApp
//
//  Created by Damir Zaripov on 22.05.2023.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    //MARK: - Elements
    private let logoLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = ""
        label.textColor = UIColor(named: "BrandBlue")
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.appName
        
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        button.backgroundColor = UIColor(named: "BrandLightBlue")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToRegisterViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToLoginViewController), for: .touchUpInside)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraints()
        

    }
    
    private func setLayout() {
        view.addSubview(logoLabel)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
    }
    
    
    private func setConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoLabel.heightAnchor.constraint(equalToConstant: 60),
            
            registerButton.topAnchor.constraint(equalTo:logoLabel.topAnchor, constant: 350),
            registerButton.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 48),
            
            loginButton.topAnchor.constraint(equalTo:registerButton.bottomAnchor, constant: 8),
            loginButton.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo:safeArea.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 61),
            
            
        ])
    }
    
    @objc private func goToRegisterViewController() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToLoginViewController() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
