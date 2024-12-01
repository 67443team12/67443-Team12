//
//  Comment.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/25.
//

import Foundation
import SwiftUI

struct Comment: Identifiable, Codable, Comparable {
  var id: String
  var userId: String
  var userName: String
  var userPhoto: String
  var content: String

  enum CodingKeys: String, CodingKey {
    case id
    case userId
    case userName
    case userPhoto
    case content
  }

  static func < (lhs: Comment, rhs: Comment) -> Bool {
    lhs.id < rhs.id
  }

  static func == (lhs: Comment, rhs: Comment) -> Bool {
    lhs.id == rhs.id
  }

  static let example1 = Comment(
    id: "23HDI6",
    userId: "Alice215",
    userName: "Alice",
    userPhoto: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/alice-icon.png?alt=media&token=1b8e454a-cec1-4433-a441-2f4d7085898d",
    content: "Nice!"
  )
  
  static let example2 = Comment(
    id: "34ASDF",
    userId: "Bob123",
    userName: "Bob",
    userPhoto: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/bob-icon.jpg?alt=media&token=a6716572-68dd-4535-94ba-4880b1e641f8",
    content: "Amazing trip! Can't wait to visit."
  )
}
