//
//  GetDataViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/03/03.
//

import UIKit
import FirebaseDatabase

class GetDataViewController: UIViewController {
  
  let db = Database.database().reference()
  
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var birthDateTextLabel: UILabel!
  @IBOutlet weak var sexTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getData()
  }
  
  private func getData() {
    db.child("sex").observeSingleEvent(of: .value) { snapshot in
      print("snapshot \(snapshot)")
      let value = snapshot.value as? String ?? ""
      DispatchQueue.main.async {
        self.sexTextLabel.text = value
      }
    } withCancel: { error in
      print(error.localizedDescription)
    }

  }
}
