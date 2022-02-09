//
//  LoginViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/02/07.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let user = Auth.auth().currentUser {
      
      emailTextField.placeholder = "이미 로그인 된 상태입니다."
      passwordTextField.placeholder = "이미 로그인 된 상태입니다."
      loginButton.setTitle("이미 로그인 된 상태입니다.", for: .normal)
      
    }
  }
  
  @IBAction func loginBtnTapped(_ sender: Any) {
    
    Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
      
      if user != nil{
        print("login success")
      } else {
        print("login fail")
      }
      
    }
  }
  
  @IBAction func signUpBtnTapped(_ sender: Any) {
    
    let mainSB = UIStoryboard(name: "Main", bundle: nil)
    let signUpVC = mainSB.instantiateViewController(withIdentifier: "SignUpVC")
    navigationController?.pushViewController(signUpVC, animated: true)
  }
  
}
