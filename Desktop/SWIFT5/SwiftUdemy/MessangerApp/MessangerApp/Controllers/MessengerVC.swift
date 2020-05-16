//
//  MessengerVC.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 14/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//



import UIKit
import Firebase

private let reuseIdentifier = "messageCell"

class MessengerVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var user : User?
    var message: [ChatMessage] = []
    
   lazy var containerView: MessageInputAccesoryView = {
    
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    let containerView = MessageInputAccesoryView(frame: frame)
    containerView.backgroundColor = .white
    return containerView
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super .viewDidLoad()
        
        // configure collection view
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        
        // set navigation Controller
        setNavigationController()
        
        // fetch messages data
        loadMessegas()
        
        // register Cell
        collectionView.register(MessengerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - NavigationController
    
    func setNavigationController() {
        
        self.navigationItem.title = "Messenger"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogOutTapped))
    }
    
    // MARK: - Handler
    
    @objc func handleLogOutTapped() {
        
        // show alert
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out?", style: .destructive, handler: { (_) in
        
        do {
             // attempt sign out
            try Auth.auth().signOut()
            
            let logoutVc = WelcomeVC()
            let navController = UINavigationController(rootViewController: logoutVc)
            
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
            print("Successfully log Out")
            
        } catch let signError as NSError {
            print("Error signing out: %@", signError.localizedDescription)
            }
    }))
        // add cancel action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController,animated: true, completion: nil)
        print("handle log Out")
    }
    
    // MARK: - show tab bar textField
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    // MARK -  Collection Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessengerCell
        
        let textMessage = message[indexPath.row]
        
        // This is a message from the current user
//        if textMessage.message == Auth.auth().currentUser?.email{
//            cell.bubbleMessage.backgroundColor = UIColor.systemBlue
//            cell.messageTxt.textColor = .yellow
//
//        } else {
//            cell.bubbleMessage.backgroundColor = UIColor.systemBlue
//            cell.messageTxt.textColor = .green
//        }
        
        cell.chatMessage = textMessage
        return cell
    }

    // MARK: - API

    func loadMessegas() {
        

        // getDocuments - kiedy chcesz dostać wszystko ale tylko raz, bez automatic refresh
        // addSnapshotListener = nasłuchuje zmian w tej kolekcji i od razu aktualizuje i wyswietla

//        Firestore.firestore().collection("messages")
//            .order(by: "date")
//            .addSnapshotListener { (querySnapshot, error) in
//
//            self.message = []
//
//            if let err = error {
//                print("There was an issue saving data to firestore, \(err)")
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
//                        self.message.append(newMessage)
//
//                        DispatchQueue.main.async {
//                            self.collectionView.reloadData()
//                            // scroll text after send then you will see new one message
//                            let indexPath = IndexPath(row: self.message.count - 1, section: 0)
//                            self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
//                        }
//                    }
//                }
//            }
//        }
   }
}

