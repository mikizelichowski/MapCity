//
//  LoginVC.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 12/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {


   override func viewDidLoad() {
       super .viewDidLoad()
       
       view.backgroundColor = .systemBlue

       [emailTextfield, passwordTextfield, loginButton].forEach{view.addSubview($0)}
       constraintComponents()
   }
   
   func constraintComponents() {
       
       NSLayoutConstraint.activate([
          
           emailTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
           emailTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
           emailTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
           emailTextfield.heightAnchor.constraint(equalToConstant: 40),
           
           passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 20),
           passwordTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
           passwordTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
           passwordTextfield.heightAnchor.constraint(equalToConstant: 40),
           
           loginButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 40),
           loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
           loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
           loginButton.heightAnchor.constraint(equalToConstant: 50)
           
       ])
   }
   

   let emailTextfield: UITextField = {
       let tf = UITextField()
       tf.placeholder = "E-mail"
       tf.text = "1@2.com"
       tf.borderStyle = .roundedRect
       tf.textColor = .black
       tf.font = UIFont.boldSystemFont(ofSize: 16)
       tf.translatesAutoresizingMaskIntoConstraints = false
       return tf
   }()
   
   let passwordTextfield: UITextField = {
       let tf = UITextField()
       tf.placeholder = "Password min 6 signs"
       tf.borderStyle = .roundedRect
       tf.text = "qqqqqq"
       tf.isSecureTextEntry = true
       tf.textColor = .black
       tf.font = UIFont.boldSystemFont(ofSize: 16)
       tf.translatesAutoresizingMaskIntoConstraints = false
       return tf
   }()
   
   
   let loginButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Log In", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(handleTappedLogin), for: .touchUpInside)
       return button
   }()
   
   @objc func handleTappedLogin() {
       
       guard let email = emailTextfield.text else { return }
       guard let password = passwordTextfield.text else { return }
       
       Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
           
           if let err = error {
               print("Failed log In \(err.localizedDescription)")
           } else {
               
               // Navigate to the ChatViewController
            //let nextScreen = UINavigationController(rootViewController: ChatVC())
            let nextScreen = UINavigationController(rootViewController: MessengerVC(collectionViewLayout: UICollectionViewFlowLayout()))
               nextScreen.modalPresentationStyle = .fullScreen
               self.present(nextScreen, animated: true, completion: nil)
               print("Successful signed user in")
               
           }
       }
   }


}
