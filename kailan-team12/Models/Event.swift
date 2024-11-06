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
  var ratings: Double
  var latitude: Double
  var longitude: Double
  var image: String
  var location: String
  var title: String
  var duration: String
  var address: String
  
  var sunday: String
  var monday: String
  var tuesday: String
  var wednesday: String
  var thursday: String
  var friday: String
  var saturday: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case startTime
    case endTime
    case ratings
    case latitude
    case longitude
    case image
    case location
    case title
    case duration
    case address
    
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
  }
  
  func toDictionary() -> [String: Any] {
          return [
              "id": id,
              "startTime": startTime,
              "endTime": endTime,
              "ratings": ratings,
              "latitude": latitude,
              "longitude": longitude,
              "image": image,
              "location": location,
              "title": title,
              "duration": duration,
              "address": address,
              
              "sunday": sunday,
              "monday": monday,
              "tuesday": tuesday,
              "wednesday": wednesday,
              "thursday": thursday,
              "friday": friday,
              "saturday": saturday
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
