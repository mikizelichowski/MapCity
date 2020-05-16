//
//  ViewController.swift
//  MessangerApp
//
//  Created by Mikolaj Zelichowski on 12/05/2020.
//  Copyright © 2020 Infusion Code. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

     
      override func viewDidLoad() {
          super.viewDidLoad()
          
          view.backgroundColor = .white
          
          // animation txt
          showLogo()
          
          [titleLabel,loginButton,registerButton].forEach{view.addSubview($0)}
          constraintComponents()
          
      }
      
      // MARK: - Animation
      
      // this is the same what CLTypingLabel
      func showLogo() {
          
          titleLabel.text = ""
          var charIndex = 0.0
          let titleText = "FlashChat . . ."
            for letter in titleText {
              Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                  self.titleLabel.text?.append(letter)
              }
              charIndex += 1
          }
      }
      
      // MARK: - Constraints
      
      func constraintComponents(){
          
          NSLayoutConstraint.activate([
              
              titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              
              loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
              loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
              loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
              loginButton.heightAnchor.constraint(equalToConstant: 50),
              
              registerButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
              registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
              registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
              registerButton.heightAnchor.constraint(equalToConstant: 50)
          ])
          
          
      }
      
      // MARK: - Components
      
      let titleLabel: UILabel = {
          let label = UILabel()
         // label.text = "FlashChat"
          label.textColor = .black
          label.font = UIFont.boldSystemFont(ofSize:  30)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      
      let loginButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("Log In", for: .normal)
          button.setTitleColor(.white, for: .normal)
          button.backgroundColor = .systemBlue
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.addTarget(self, action: #selector(handleTappedLogin), for: .touchUpInside)
          return button
      }()
      
      let registerButton: UIButton = {
          let button = UIButton(type: .system)
          button.setTitle("Register", for: .normal)
          button.setTitleColor(.systemBlue, for: .normal)
          button.backgroundColor = .white
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.addTarget(self, action: #selector(handleTappedRegister), for: .touchUpInside)
          return button
      }()
      
      // MARK: - Handler
      
      @objc func handleTappedLogin() {
          
          let loginVc = LoginVC()
          //loginVc.modalPresentationStyle = .fullScreen
          navigationController?.pushViewController(loginVc, animated: true)
      }
      
      @objc func handleTappedRegister() {
          
          let registerVc = RegisterVC()
          //registerVc.modalPresentationStyle = .fullScreen
          navigationController?.pushViewController(registerVc, animated: true)
      }
}

