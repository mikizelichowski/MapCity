//
//  ChatVC.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 12/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit
import Firebase

private let messageReuseIdentifier = "MessageCell"

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Reference
    
    let db = Firestore.firestore()
    
    // MARK: - Properties
    
  //  var chat: [ChatMessage] = []
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .systemBlue
        container.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        
        container.addSubview(commentTextField)
        commentTextField.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        commentTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8).isActive = true
        commentTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0).isActive = true
        commentTextField.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
        
        
        container.addSubview(postButton)
        postButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
        postButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        
        return container
    }()
    
    let commentTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter comment..."
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
            
    var tableView = UITableView()
    
    var chat: [ChatMessage] =
        [
        ChatMessage(text: "hey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third line", isIncoming: true),
        ChatMessage(text: "hey! We want to provide a longer string that is actually going to wrap onto the le", isIncoming: false),
        ChatMessage(text: "hey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third line, hey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third line", isIncoming: true),
        ChatMessage(text: "hey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third line, hey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third linehey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third line, hey! We want to provide a longer string that is actually going to wrap onto the line and maybe even a third line", isIncoming: false)
        ]

      // MARK: - Init
    
      override func viewDidLoad() {
          super.viewDidLoad()
      
          setupNavBar()
          configureTableView()
          view.addSubview(containerView)
        
        // fetch messages from data Firestore
        //loadMessages()
      }

    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
      // MARK: - TableView Configure
      
      func configureTableView() {
          
          // set subview
          view.addSubview(tableView)
        
          // set delegate
          setDelegate()
          
          // set register Cell
          tableView.register(MessageCell.self, forCellReuseIdentifier: messageReuseIdentifier)
         
          // set costraint
          tableView.pin(to: view)
          
          // settings
          tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
          tableView.separatorStyle = .none
      }
      
      // MARK: - NavigationController
      
      func setupNavBar()
      {
      navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 12)!]

      self.navigationItem.title = "Chat Messanger"
      self.navigationController?.navigationBar.backgroundColor = UIColor.white
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleTappedLogout))
      self.navigationController?.navigationBar.tintColor = .black
      // hide bars when you scroll down
      // self.navigationController?.hidesBarsOnSwipe = true
      //navigationItem.largeTitleDisplayMode = .never
      }
      
      // MARK: - Handler
      @objc func handleTappedLogout()
      {
          // declare alert controller
          let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
          alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
              
            do {
                // attempt sign out
                try Auth.auth().signOut()
                  
                let logoutvc = WelcomeVC()
                let navController = UINavigationController(rootViewController: logoutvc)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController,animated: true, completion: nil)
                  
                print("Successfully log out")
                  
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError.localizedDescription)
            }
          }))
          // add cancel action
          alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          present(alertController, animated: true, completion: nil)
          print("handle log Out")
      }
      
      // MARK: - Delegates
      
      func setDelegate() {
          
          tableView.delegate = self
          tableView.dataSource = self
    }
}

      
extension ChatVC {
        
    // MARK: - TableView Delegate
          
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
              print(indexPath.row)
          }
    
    
    // MARK: - Data Source
      
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return chat.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: messageReuseIdentifier, for: indexPath) as! MessageCell
         
          let dataMessages = chat[indexPath.row]
            cell.chatMessage = dataMessages
            
          return cell
        }
    
//    func loadMessages() {
//
//    Firestore.firestore().collection("message").order(by: "date")
//        .addSnapshotListener { (querySnapshot, error) in
//
//            self.chat = []
//
//            if let err = error {
//                print("There was an issue saving data to firestore \(err)")
//            } else {
//                if let snapshotDocuments = querySnapshot?.documents {
//
//                    for doc in snapshotDocuments {
//
//                        let data = doc.data()
//
//                        guard let messageSender = data["message"] as? String else { return }
//                        guard let messageBody = data["bodyfield"] as? String else { return }
//
//                        let newMessage = ChatMessage(text: "", isIncoming: false, message: messageSender, body: messageBody)
//
//                        self.chat.append(newMessage)
//
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//
//                            let indexPath = IndexPath(row: self.chat.count - 1, section: 0)
//                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                        }
//                    }
//                }
//            }
//        }
//    }
}
