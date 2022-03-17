//
//  TestLoginViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/03/03.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TestLoginViewController: UIViewController {
  
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func loginBtnTapped(_ sender: Any) {
    guard let email = idTextField.text,
          let password = passwordTextField.text else { return }

    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
      if user != nil{
        print("login success")
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = mainSB.instantiateViewController(withIdentifier: "PhotoUploadVC")
        let userEmail = UserDefaults.standard.set(self.idTextField.text!, forKey: "userEmail")
        self.navigationController?.pushViewController(photoVC, animated: true)
      }

      else {
        print("login fail")
      }
    }
    
    
  }
  
  @IBAction func signUpBtnTapped(_ sender: Any) {
    let mainSB = UIStoryboard(name: "Main", bundle: nil)
    let signUpVC = mainSB.instantiateViewController(withIdentifier: "TestSignUpVC")
    navigationController?.pushViewController(signUpVC, animated: true)
  }
}
