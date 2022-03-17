//
//  SignUpViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/02/03.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func continueBtnTapped(_ sender: Any) {
    guard let email = emailTextField.text,
          !email.isEmpty,
          let password = passwordTextField.text,
          !password.isEmpty else { print("Missing field data")
            return
          }
    
    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
      
      print(error?.localizedDescription)
      
      if user != nil {
        print("register success")
      } else {
        print("register failed")
      }
    }
  }
  
}

