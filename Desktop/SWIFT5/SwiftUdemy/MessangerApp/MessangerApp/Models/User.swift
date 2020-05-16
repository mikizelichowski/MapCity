//
//  User.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 15/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    // attributes
    var uid: String!
    var username: String!
    var profileImageUrl: String!
    
    init(uid: String, dictionary: [String: AnyObject]) {
        
        self.uid = uid
        
        if let username = dictionary["username"] as? String {
            self.username = username
        }
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = profileImageUrl
        }
        
    }
}
