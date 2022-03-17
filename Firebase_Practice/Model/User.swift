//
//  User.swift
//  Firebase_Practice
//
//  Created by 신미지 on 2022/03/15.
//

import Foundation

public struct User: Codable {
  let birthDate: String?
  let sex: String?
  let userId: String?
  
  enum CodingKeys: String, CodingKey {
    case birthDate
    case sex
    case userId
  }
  
}
