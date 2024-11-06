//
//  Event.swift
//  kailan-team12
//
//  Created by k mao on 11/4/24.
//

import Foundation

struct Event: Identifiable, Codable, Hashable {
  var id: String
  var startTime: String
  var endTime: String
  var rating: Double
  var latitude: Double
  var longitude: Double
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
    case name
  }
  
  func toDictionary() -> [String: Any] {
          return [
              "id": id,
              "startTime": startTime,
              "endTime": endTime,
              "rating": rating,
              "latitude": latitude,
              "longitude": longitude,
              "image": image,
              "name": name
              // Include other fields if applicable
          ]
    }
  
  func hash(into hasher: inout Hasher) {
      hasher.combine(id)

  }
  
  func startTimeAsDate() -> Date? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "h:mm a" // Matches "9:00 AM", "10:30 PM", etc.
          return dateFormatter.date(from: startTime)
      }
}
