//
//  MessageCell.swift
//  ChatApp
//
//  Created by Damir Zaripov on 22.05.2023.
//

import UIKit

class MessageCell: UITableViewCell {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "BrandLightPurple")
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let meAvatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "MeAvatar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let youAvatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "YouAvatar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var chatCloud: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [messageLabel])
        stack.backgroundColor = UIColor(named: "BrandPurple")
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .top
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: K.cellIdentifier)
        
        contentView.addSubview(chatCloud)
        contentView.addSubview(meAvatarImage)
        contentView.addSubview(youAvatarImage)
        
        
        NSLayoutConstraint.activate([
            
            chatCloud.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            chatCloud.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            chatCloud.leadingAnchor.constraint(equalTo: youAvatarImage.trailingAnchor, constant: 10),
            
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: chatCloud.leadingAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: chatCloud.trailingAnchor, constant: -10),
            
            meAvatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            meAvatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            meAvatarImage.leadingAnchor.constraint(equalTo: chatCloud.trailingAnchor, constant: 10),
            meAvatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            meAvatarImage.heightAnchor.constraint(equalToConstant: 40),
            meAvatarImage.widthAnchor.constraint(equalToConstant: 40),
            
            youAvatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            youAvatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            youAvatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            youAvatarImage.trailingAnchor.constraint(equalTo: chatCloud.leadingAnchor, constant: -10),
            youAvatarImage.heightAnchor.constraint(equalToConstant: 40),
            youAvatarImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
