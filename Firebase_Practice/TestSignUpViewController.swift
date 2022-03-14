//
//  TestSignUpViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/02/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class TestSignUpViewController: UIViewController {
  
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var birthDateTextField: UITextField!
  
  @IBOutlet weak var femaleButton: UIButton!
  @IBOutlet weak var maleButton: UIButton!
  
  var userSex: String = ""
  
  //  var ref = Database.database().reference()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
  }
  
  private func configureGetData() {
//    db.collection("users").document().
    
  }
  
  private func configureTextField() {
    idTextField.delegate = self
    passwordTextField.delegate = self
    birthDateTextField.delegate = self
  }
  
  @IBAction func IdCheckBtnTapped(_ sender: Any) {
    if idTextField.text == "" {
      let alertVC = UIAlertController(title: "확인!", message: "빈칸이 있어요.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "네", style: .default, handler: nil)
      alertVC.addAction(okAction)
      self.present(alertVC, animated: true, completion: nil)
    } else {
      guard let id = idTextField.text else { return }
      let documentRef = Firestore.firestore().document("users/\(id)")
      documentRef.getDocument { (snapshot, error) in
        guard let data = snapshot?.data(), error == nil else { return }
        print("error is \(error?.localizedDescription)")
        print("data is \(data)")
      }
    }
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
    if idTextField.text == "" || passwordTextField.text == "" || birthDateTextField.text == "" || userSex == "" {
      let alertVC = UIAlertController(title: "확인!", message: "빈칸이 있어요.", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "네", style: .default, handler: nil)
      alertVC.addAction(okAction)
      self.present(alertVC, animated: true, completion: nil)
    } else {
      let db = Firestore.firestore()
      let newDocument = db.collection("users").document()
      guard let id = idTextField.text,
            let password = passwordTextField.text,
            let birthDate = birthDateTextField.text else { return }
      
      Auth.auth().createUser(withEmail: id, password: password) { [self] (authResult, error) in
        guard let user = authResult?.user, error == nil else {
          print(error?.localizedDescription)
          return
        }
        
        newDocument.setData(["id": id, "password": password, "birthDate": birthDate, "sex": userSex, "userId": newDocument.documentID])
        self.navigationController?.popViewController(animated: true)
      }
      //    guard let userEmail = idTextField.text,
      //          let userPassword = passwordTextField.text,
      //          let birthDate = birthDateTextField.text else { return }
      //    Auth.auth().createUser(withEmail: userEmail, password: userPassword) { [self] (authResult, error) in
      //      guard let user = authResult?.user, error == nil else {
      //        print(error?.localizedDescription)
      //        return
      //      }
      //      ref.child("users").child(user.uid).setValue(["birthDate": birthDate, "sex": userSex])
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
