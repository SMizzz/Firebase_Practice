//
//  GetDataViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/03/03.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class GetDataViewController: UIViewController {
  
  let db = Firestore.firestore()
  
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var birthDateTextLabel: UILabel!
  @IBOutlet weak var sexTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
  }
  
  private func getData() {
//    guard let userEmail = UserDefaults.standard.string(forKey: "userEmail") else { return }
//    let docRef = db.collection("users").document(userEmail)
    
    db.collection("expert").getDocuments { (document, error) in
      if let err = error {
        print("error is \(error)")
      } else {
        for docu in document!.documents {
          guard let expertName = docu.data()["name"] as? String,
                let acquisitionDate = docu.data()["acquisitionDate"] as? String else { return }
          DispatchQueue.main.async {
            self.sexTextLabel.text = expertName
            self.birthDateTextLabel.text = acquisitionDate
          }
//          print("docu is \(docu.data())")
        }
      }
    }
//    docRef.getDocument { (document, error) in
//      guard let data = document?.data(), error == nil else { return }
//
//      guard let birthDateText = data["birthDate"] as? String else { return }
//      guard let sexText = data["sex"] as? String else { return }
//
//
//      DispatchQueue.main.async {
//        self.birthDateTextLabel.text = birthDateText
//        self.sexTextLabel.text = sexText
//      }
//    }
    
    //    docRef.getDocument(source: .cache) { (document, error) in
    //      if let document = document {
    //        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
    //        print("Cached document data: \(dataDescription)")
    //      } else {
    //        print("Document does not exist in cache")
    //      }
  }
}
