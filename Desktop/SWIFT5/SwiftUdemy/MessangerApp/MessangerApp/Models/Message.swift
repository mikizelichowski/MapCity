//
//  Message.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 12/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import Foundation
    
class ChatMessenger {
    
    var senderUser: User?
    var ownerUid: String!
    var creationDate: Date!
    var messageBody: String!
    var imageUrl: String!
    
    init(senderUser: User, dictionary: Dictionary<String, AnyObject>) {
        
        self.senderUser = senderUser
        
        if let ownerUid = dictionary["ownerUid"] as? String {
            self.ownerUid = ownerUid
        }
        
        if let messageBody = dictionary["messageBody"] as? String {
            self.messageBody = messageBody
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        
        if let creationDate = dictionary["creationDate"] as? Double {
            self.creationDate = Date(timeIntervalSince1970: creationDate)
        }
        
    }
}




struct ChatMessage {

    let text: String
    let isIncoming: Bool
    //let message: String
   // let body: String
}
  

struct User11 {
    let message: String
    let profileImageUrl: String
    let body: String
    let uid: String
}
