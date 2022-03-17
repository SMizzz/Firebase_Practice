//
//  PhotoUploadViewController.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/02/08.
//

import UIKit
import FirebaseStorage

class  PhotoUploadViewController: UIViewController {
  @IBOutlet weak var photoImageView: UIImageView!
  
  let storage = Storage.storage().reference()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
          let url = URL(string: urlString) else { return }
  }
  
  private func configureUploadImage(image: UIImage) {
//    guard let imageData = image.pngData() else { return }
//    storage.child("images/file.png").putData(imageData, metadata: nil) { _, error in
//      guard error == nil else {
//        print("Failed to upload")
//        return
//      }
//
//    }
  }
  
  @IBAction func pickPhotoBtnTapped(_ sender: Any) {
    let pickerVC = UIImagePickerController()
    pickerVC.sourceType = .photoLibrary
    pickerVC.delegate = self
    pickerVC.allowsEditing = true
    present(pickerVC, animated: true, completion: nil)
  }
  
  @IBAction func uploadBtnTapped(image: UIImage) {
//    let randomID = UUID.init().uuidString
    guard let imageData = image.pngData() else { return }
    storage.child("images/file.png").putData(imageData, metadata: nil) { _, error in
      guard error == nil else {
        print("Failed to upload")
        return
      }
      
      let mainSB = UIStoryboard(name: "Main", bundle: nil)
      let getDataVC = mainSB.instantiateViewController(withIdentifier: "GetDataVC")
      self.navigationController?.pushViewController(getDataVC, animated: true)
      
    }
  }
}

extension PhotoUploadViewController:
  UIImagePickerControllerDelegate,
  UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
      return
    }
    print("image is \(image)")
    photoImageView.image = image
    self.dismiss(animated: true, completion: nil)
    uploadBtnTapped(image: image)
    //    guard let imageData = image.pngData() else { return }
    
    // /Desktop/file.png
    //    storage.child("images/file.png").putData(imageData, metadata: nil) { _, error in
    //      guard error == nil else {
    //        print("Failed to upload")
    //        return
    //      }
    //      self.storage.child("images/file.png").downloadURL { url, error  in
    //        guard let url = url, error == nil else { return }
    //        let urlString = url.absoluteString
    //        print("Download URL: \(urlString)")
    //        UserDefaults.standard.set(urlString, forKey: "url")
    //      }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
