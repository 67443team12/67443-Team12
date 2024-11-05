//
//  Event.swift
//  kailan-team12
//
//  Created by k mao on 11/4/24.
//

import Foundation

struct Event: Identifiable, Codable {
  var id: String
  var startTime: String
  var endTime: String
  var rating: Float
  var latitude: Float
  var longitude: Float
  var image: String
  var name: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case startTime
    case endTime
    case rating
    case latitude
    case longitude
    case image
    case name = "locationName"
  }
}
