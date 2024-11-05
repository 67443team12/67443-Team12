//
//  Location.swift
//  kailan-team12
//
//  Created by k mao on 11/4/24.
//

import Foundation

struct Location: Identifiable, Codable {
  
  var id = UUID()
  var longitude: Double
  var latitude: Double
  var name: String
  
  // To conform to Codable protocol
  enum CodingKeys: String, CodingKey {
    case longitude
    case latitude
    case name = "locationName"
  }
  
}
