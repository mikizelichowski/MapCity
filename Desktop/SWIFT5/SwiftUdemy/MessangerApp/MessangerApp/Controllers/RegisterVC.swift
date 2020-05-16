//
//  RegisterVC.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 12/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

   override func viewDidLoad() {
       super .viewDidLoad()
       
       view.backgroundColor = .white
       
       [usernameTextfield,emailTextfield, passwordTextfield, registerButton].forEach{view.addSubview($0)}
       constraintComponents()
   }
   
   func constraintComponents() {
       
       NSLayoutConstraint.activate([
        
        usernameTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        usernameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        usernameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        usernameTextfield.heightAnchor.constraint(equalToConstant: 40),
       
       emailTextfield.topAnchor.constraint(equalTo: usernameTextfield.topAnchor,constant: 50),
       emailTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
       emailTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
       emailTextfield.heightAnchor.constraint(equalToConstant: 40),
       
       passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 20),
       passwordTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
       passwordTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
       passwordTextfield.heightAnchor.constraint(equalToConstant: 40),
       
       registerButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 40),
       registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
       registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
       registerButton.heightAnchor.constraint(equalToConstant: 50)
           
       ])
   }
   
   // MARK: - Handler, Create User
   
   @objc func handleRegisterTapped() {
       
    guard let username = usernameTextfield.text else { return }
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
    
       Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
           if let err = error {
               print("Failed create new user \(err.localizedDescription)")
           }
               
            guard let uid = user?.user.uid else { return }
            
        let dictionaryValues = [    "username": username,
                                    "email" : email,
                                    "password": password]
            
            // create tree on Firebase
            let values = [uid: dictionaryValues]
           
            // save user info to database
        Database.database().reference().child("users").updateChildValues(values) {
            (error, ref) in
            print("Successfully created user and saved information to database")
        }
    }
               // Navigate to the ChatViewController
               let nextScreen = UINavigationController(rootViewController: ChatVC())
               nextScreen.modalPresentationStyle = .fullScreen
               self.present(nextScreen, animated: true, completion: nil)
               print("Successful user register")
   }
    
    // MARK: - Properties
    
    let usernameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User name"
        tf.textColor = .black
        tf.textAlignment = .left
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        return tf
    }()
   
   let emailTextfield: UITextField = {
       let tf = UITextField()
       tf.placeholder = "E-mail"
       tf.textColor = .black
       tf.borderStyle = .roundedRect
       tf.keyboardType = .emailAddress
       tf.keyboardAppearance = .dark
       tf.textAlignment = .left
       tf.font = UIFont.boldSystemFont(ofSize: 16)
       tf.translatesAutoresizingMaskIntoConstraints = false
       return tf
   }()
   
   let passwordTextfield: UITextField = {
       let tf = UITextField()
       tf.placeholder = "Password"
       tf.isSecureTextEntry = true
       tf.textColor = .black
       tf.textAlignment = .left
       tf.borderStyle = .roundedRect
       tf.keyboardAppearance = .dark
       tf.keyboardType = .default
       tf.font = UIFont.boldSystemFont(ofSize: 16)
       tf.translatesAutoresizingMaskIntoConstraints = false
       return tf
   }()
   
   
   let registerButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Register", for: .normal)
       button.setTitleColor(.systemBlue, for: .normal)
       button.backgroundColor = .white
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
       button.translatesAutoresizingMaskIntoConstraints = false
       button.addTarget(self, action: #selector(handleRegisterTapped), for: .touchUpInside)
       return button
   }()
    
    // MARK: - function keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    private func closeKeyboard() {
        view.endEditing(true)
    }

}
