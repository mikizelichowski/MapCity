//
//  MessengerCell.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 14/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit
import Firebase

class MessengerCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var imageLeadingConstraint: NSLayoutConstraint!
    var imageTrailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
               // messageTxt.text = chatMessage.body
//            bubbleMessage.backgroundColor = chatMessage.isIncoming ? .green : .systemBlue
//            messageTxt.textColor = chatMessage.isIncoming ? .black : .white
            
//            if chatMessage.message == Auth.auth().currentUser?.email {
//             //   bubbleMessage.backgroundColor = .systemBlue
//                messageTxt.textColor = .white
//////                leadingConstraint.isActive = true
//////                trailingConstraint.isActive = false
//////                imageLeadingConstraint.isActive = false
//////                imageTrailingConstraint.isActive = true
////
//            } else {
//                bubbleMessage.backgroundColor = .systemGreen
//                messageTxt.textColor = .black
//////                leadingConstraint.isActive = false
//////                trailingConstraint.isActive = true
//////                imageLeadingConstraint.isActive = false
//////                imageTrailingConstraint.isActive = true
////
//            }
            
           // messageTxt.text = chatMessage.text
            
//            if chatMessage.isIncoming {
//                leadingConstraint.isActive = true
//                trailingConstraint.isActive = false
//                imageLeadingConstraint.isActive = false
//                imageTrailingConstraint.isActive = true
//            } else {
//                leadingConstraint.isActive = false
//                trailingConstraint.isActive = true
//                imageLeadingConstraint.isActive = false
//                imageTrailingConstraint.isActive = true
//            }
        }
    }
    
    let bubbleMessage: UIView = {
        let bv = UIView()
        bv.backgroundColor = .systemBlue
        return bv
    }()
    
    let messageTxt: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let imageProfile: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 40 / 2
        return iv
    }()
    
    func constraintComponents() {
        
        bubbleMessage.anchor(top: messageTxt.topAnchor, leading: messageTxt.leadingAnchor, bottom: messageTxt.bottomAnchor, trailing: messageTxt.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        messageTxt.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: nil, padding: .init(top: 32, left: 0, bottom: -32, right: 0))
        messageTxt.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        imageProfile.anchor(top: bubbleMessage.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        imageProfile.anchorWidHig(width: 40, height: 40)
        
        leadingConstraint = messageTxt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageTxt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
        imageLeadingConstraint = imageProfile.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        imageLeadingConstraint.isActive = true
        
        imageTrailingConstraint = imageProfile.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        imageTrailingConstraint.isActive = false
    
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        [bubbleMessage, messageTxt, imageProfile].forEach{addSubview($0)}
        constraintComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
