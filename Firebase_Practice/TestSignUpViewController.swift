//
//  TestSignUpViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/02/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TestSignUpViewController: UIViewController {
  
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var birthDateTextField: UITextField!
  
  @IBOutlet weak var femaleButton: UIButton!
  @IBOutlet weak var maleButton: UIButton!
  
  var userSex: String = ""
  
  var ref = Database.database().reference()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
  }
  
  private func configureTextField() {
    idTextField.delegate = self
    passwordTextField.delegate = self
    birthDateTextField.delegate = self
  }
  
  @IBAction func femaleBtnTapped(_ sender: Any) {
    femaleButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
    femaleButton.setTitle("여자 ", for: .normal)
    femaleButton.tintColor = UIColor.blue
    
    maleButton.setImage(UIImage(systemName: "circle"), for: .normal)
    maleButton.setTitle("남자 ", for: .normal)
    
    userSex = femaleButton.currentTitle!
  }
  
  @IBAction func maleBtnTapped(_ sender: Any) {
    maleButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
    maleButton.setTitle("남자 ", for: .normal)
    maleButton.tintColor = UIColor.blue
    
    femaleButton.setImage(UIImage(systemName: "circle"), for: .normal)
    femaleButton.setTitle("여자 ", for: .normal)
    
    userSex = maleButton.currentTitle!
  }
  
  @IBAction func signUpBtnTapped(_ sender: Any) {
    guard let userEmail = idTextField.text,
          let userPassword = passwordTextField.text,
          let birthDate = birthDateTextField.text else { return }
    Auth.auth().createUser(withEmail: userEmail, password: userPassword) { [self] authResult, error in
      guard let user = authResult?.user, error == nil else {
        print(error?.localizedDescription)
        return
      }
      ref.child("users").child(user.uid).setValue(["birthDate": birthDate, "sex": userSex])
    }
  }
  
}

extension TestSignUpViewController: UITextFieldDelegate {
  
  // 엔터키를 눌렀을 때 취해야하는 동작
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case idTextField:
      passwordTextField.becomeFirstResponder()
    case passwordTextField:
      birthDateTextField.becomeFirstResponder()
    default:
      textField.resignFirstResponder()
    }
    return false
  }
}
