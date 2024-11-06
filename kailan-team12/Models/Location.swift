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
    case id = "locationId"
    case longitude
    case latitude
    case name = "locationName"
    case description
    case ratings
    case duration = "estimateDuration"
    case image
    
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
  }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)

  }
  
}
