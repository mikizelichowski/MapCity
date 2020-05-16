//
//  MessageInputAccesoryView.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 14/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit
import Firebase

class MessageInputAccesoryView: UIView {

    // MARK: - Reference
    
    let db = Firestore.firestore()
    
    var chat: ChatMessage!
     
    
   let commentTextView: MessageInputTextView = {
        let tv = MessageInputTextView()
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
     }()
    
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTappedSend), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        autoresizingMask = .flexibleHeight
        
        addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        sendButton.anchorWidHig(width: 50, height: 50)
        
        addSubview(commentTextView)
        commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant:0).isActive = true
        
        
        let seperateView = UIView()
         addSubview(seperateView)
         seperateView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
         seperateView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
         seperateView.anchorWidHig(width: 0, height: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    func clearCommentTextView() {
        commentTextView.placeholderLabel.isHidden = false
        commentTextView.text = nil
    }
    // MARK: - Handers
    
    
    // Save data in FireStore
    @objc func handleTappedSend() {
        
        guard let messageBody = commentTextView.text else { return }
        guard  let currentUidUser = Auth.auth().currentUser?.uid else { return }
       
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        // post data
        let values = [  "message": messageBody,
                        "currentUser": currentUidUser,
                        "creationDate": creationDate] as [String : Any]
        
        // post id
        let postId = Database.database().reference().child("messageBody").childByAutoId()
        guard let postKey = postId.key else { return }
        // upload information to database
        postId.updateChildValues(values, withCompletionBlock: { (err, ref) in
        
            // upload information to database
            let userPostRef = Database.database().reference().child("chat-post").child(currentUidUser)
            userPostRef.updateChildValues([postKey: 1])
            
            print("Successfully saved data")
        })
       


//        let docData: [String: Any] = [fileName:
//                                            ["message": messageSender,
//                                             "bodyField": messageBody],
//                                    "date": Date().timeIntervalSince1970]
//        db.collection("User").document(fileName).setData(docData, merge: true) { (error) in
//                if let err = error {
//                    print("There was an issue saving data to firestore, \(err)")
//                } else {
//                    print("Successfully saved data")
//
//                    // after send, textfield is clean
//                    DispatchQueue.main.async {
//                        self.commentTextView.text = ""
//                }
//            }
//        }
    }
    
}
