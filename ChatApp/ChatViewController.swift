//
//  ViewController.swift
//  ChatApp
//
//  Created by Damir Zaripov on 22.05.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    //MARK: - Variables
    
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    //MARK: - Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MessageCell.self, forCellReuseIdentifier: "cellID")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let messageInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write a message..."
        textField.backgroundColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.white.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        return button
    }()
    
    
    lazy var logoutButton: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutPressed))
        button.tintColor = UIColor.white
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        navigationController?.navigationBar.tintColor = UIColor(named: K.BrandColors.blue)
        navigationController?.navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = logoutButton
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(MessageCell.self, forCellReuseIdentifier: K.cellIdentifier)
        setLayout()
        setConstraints()
        
        loadMessages()
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        view.addSubview(messageInput)
        
        view.addSubview(sendButton)
    }
    
    
    private func setConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -70),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            messageInput.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            messageInput.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            messageInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageInput.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -30),
            messageInput.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            sendButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            sendButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            
        ])
        
        
    }
    
    @objc private func sendPressed() {
        
        if let messageBody = messageInput.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ], completion: {(error) in
                if let e = error {
                    print("An error saving data to firestore - \(e)")
                } else {
                    print("Successfully saved")
                    DispatchQueue.main.async {
                        self.messageInput.text = ""
                    }
                }
            })
            
        }
    }
    
    @objc private func logoutPressed() {
        
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        }   catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving your data - \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)

                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youAvatarImage.isHidden = true
            cell.meAvatarImage.isHidden = false
            cell.chatCloud.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.youAvatarImage.isHidden = false
            cell.meAvatarImage.isHidden = true
            cell.chatCloud.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
