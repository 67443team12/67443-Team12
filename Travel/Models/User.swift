//
//  User.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable, Comparable {
  // Properties
  var id: String
  var name: String
  var photo: String
  var Posts: [String]
  var Bookmarks: [String]
  var Trips: [String]
  var Friends: [String]
  var Requests: [String]
  
  // Coding Keys
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case photo
    case Posts
    case Bookmarks
    case Trips
    case Friends
    case Requests
  }
  
  // Comparable Protocol
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: User, rhs: User) -> Bool {
    lhs.id == rhs.id
  }
  
  // Convert User to a dictionary
  func toDictionary() -> [String: Any] {
    return [
      "id": id,
      "name": name,
      "photo": photo,
      "Posts": Posts,
      "Bookmarks": Bookmarks,
      "Trips": Trips,
      "Friends": Friends,
      "Requests": Requests
    ]
  }
}
