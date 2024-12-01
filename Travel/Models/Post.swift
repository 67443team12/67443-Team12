//
//  Post.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct Post: Identifiable, Codable, Comparable {
  var id: String
  var title: String
  var time: String
  var content: String
  var userId: String
  var userName: String
  var userPhoto: String
  var ifBookmarked: Bool
  var comments: [Comment]
  var photo: String

  enum CodingKeys: String, CodingKey {
    case id
    case title
    case time
    case content
    case userId
    case userName
    case userPhoto
    case ifBookmarked
    case comments
    case photo
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    time = try container.decode(String.self, forKey: .time)
    content = try container.decode(String.self, forKey: .content)
    userId = try container.decode(String.self, forKey: .userId)
    userName = try container.decode(String.self, forKey: .userName)
    userPhoto = try container.decode(String.self, forKey: .userPhoto)
    ifBookmarked = try container.decode(Bool.self, forKey: .ifBookmarked)
    comments = (try? container.decode([Comment].self, forKey: .comments)) ?? [] // Default to empty array
    photo = try container.decode(String.self, forKey: .photo)
  }

  init(
    id: String,
    title: String,
    time: String,
    content: String,
    userId: String,
    userName: String,
    userPhoto: String,
    ifBookmarked: Bool,
    comments: [Comment] = [],
    photo: String = ""
  ) {
    self.id = id
    self.title = title
    self.time = time
    self.content = content
    self.userId = userId
    self.userName = userName
    self.userPhoto = userPhoto
    self.ifBookmarked = ifBookmarked
    self.comments = comments
    self.photo = photo
  }

  static func < (lhs: Post, rhs: Post) -> Bool {
    lhs.time < rhs.time
  }

  static func == (lhs: Post, rhs: Post) -> Bool {
    lhs.id == rhs.id
  }

  static let example1 = Post(
    id: "35FNRV",
    title: "Pittsburgh Adventures",
    time: "2024-10-16",
    content: "So nice to see Pittsburgh transformed into a city advocated for innovation and education! The visit to the Duquesne Incline was fantastic!",
    userId: "Bob1241",
    userName: "Bob",
    userPhoto: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/bob-icon.jpg?alt=media&token=a6716572-68dd-4535-94ba-4880b1e641f8",
    ifBookmarked: true,
    comments: [Comment.example1, Comment.example2],
    photo: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/trip_photos%2F27996353-DF93-4463-83C1-83C29199FB24.jpg?alt=media&token=1cfcdda6-e4f1-4dfe-b3f4-24eb4ab4bfdc"
  )

  static let example2 = Post(
    id: "5MT4E8",
    title: "I LOVE New York",
    time: "2024-11-01",
    content: "I had the most amazing evening walking along the riverside in New York. Make sure to check out Brooklyn Bridge Park, the High Line, Central Park, and Battery Park!",
    userId: "Alice215",
    userName: "Alice",
    userPhoto: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/alice-icon.png?alt=media&token=1b8e454a-cec1-4433-a441-2f4d7085898d",
    ifBookmarked: false,
    comments: [],
    photo: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/trip_photos%2F71A91907-2CF0-4D68-9593-913A7CEA5386.jpg?alt=media&token=513a0b6e-5fcb-4b87-823a-1ab61e2efc41"
  )
}
