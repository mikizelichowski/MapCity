//
//  MessageCell.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 13/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {

    // MARK: - Properties
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var imageLeadingConstraint: NSLayoutConstraint!
    var imageTrailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            messageBubble.backgroundColor = chatMessage.isIncoming ? .green : .systemBlue
            messageText.textColor = chatMessage.isIncoming ? .black : .white

            messageText.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                imageTrailingConstraint.isActive = true
                imageLeadingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                imageLeadingConstraint.isActive = true
                imageTrailingConstraint.isActive = false
            }
            
        }
    }

    let messageBubble: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageText: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .systemGreen
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageProfile: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 40 / 2
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    // MARK: - Constraint
    func componentsConstraint(){
        
        NSLayoutConstraint.activate([
            
            messageBubble.topAnchor.constraint(equalTo: messageText.topAnchor, constant: -16),
            messageBubble.bottomAnchor.constraint(equalTo: messageText.bottomAnchor, constant: 16),
            messageBubble.leadingAnchor.constraint(equalTo: messageText.leadingAnchor, constant: -16),
            messageBubble.trailingAnchor.constraint(equalTo: messageText.trailingAnchor, constant: 16),
      
            imageProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            //imageProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            imageProfile.widthAnchor.constraint(equalToConstant: 40),
            imageProfile.heightAnchor.constraint(equalToConstant: 40),

            messageText.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageText.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
        
        leadingConstraint =  messageText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
        imageLeadingConstraint = imageProfile.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        imageLeadingConstraint.isActive = true
        
        imageTrailingConstraint = imageProfile.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        imageTrailingConstraint.isActive = false
    }
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        //backgroundColor = .clear
        
    [messageBubble,imageProfile,messageText].forEach{addSubview($0)}
        componentsConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
