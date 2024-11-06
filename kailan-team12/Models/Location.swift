//
//  Location.swift
//  kailan-team12
//
//  Created by k mao on 11/4/24.
//

import Foundation

struct Location: Identifiable, Codable, Hashable {
  
  var id: String
  var longitude: Double
  var latitude: Double
  var name: String
  var description: String
  var ratings: Double
  var duration: String
  var image: String
  var address: String
  
  // hours
  var sunday: String
  var monday: String
  var tuesday: String
  var wednesday: String
  var thursday: String
  var friday: String
  var saturday: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case id
    case longitude
    case latitude
    case name
    case description
    case ratings
    case duration
    case image
    case address
    
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)

  }
  
}
