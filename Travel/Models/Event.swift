//
//  Event.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Comparable, Codable {
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
  var monday: String
  var tuesday: String
  var wednesday: String
  var thursday: String
  var friday: String
  var saturday: String
  var sunday: String
  
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
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
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
    ]
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  func startTimeAsDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.date(from: startTime)
  }

  func endTimeAsDate() -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.date(from: endTime)
  }
  
  static func < (lhs: Event, rhs: Event) -> Bool {
    lhs.startTime < rhs.startTime
  }
  
  static func == (lhs: Event, rhs: Event) -> Bool {
    lhs.id < rhs.id
  }
  
  static let example1 = Event(
    id: "1",
    startTime: "13:00:00",
    endTime: "14:00:00",
    ratings: 4.8,
    latitude: 25.77542312073535,
    longitude: -80.18616744670095,
    image: "",
    location: "Bayfront Park",
    title: "Bayfront Park Hangout",
    duration: "3-4 hours",
    address: "301 Biscayne Blvd, Miami, FL 33132",
    monday: "9AM - 9PM",
    tuesday: "9AM - 9PM",
    wednesday: "9AM - 9PM",
    thursday: "9AM - 9PM",
    friday: "9AM - 9PM",
    saturday: "9AM - 9PM",
    sunday: "9AM - 9PM"
  )
  
  static let example2 = Event(
    id: "2",
    startTime: "15:00:00",
    endTime: "17:00:00",
    ratings: 4.8,
    latitude: 25.77542312073535,
    longitude: -80.18616744670095,
    image: "",
    location: "Bayfront Park",
    title: "Bayfront Park Hangout",
    duration: "3-4 hours",
    address: "301 Biscayne Blvd, Miami, FL 33132",
    monday: "9AM - 9PM",
    tuesday: "9AM - 9PM",
    wednesday: "9AM - 9PM",
    thursday: "9AM - 9PM",
    friday: "9AM - 9PM",
    saturday: "9AM - 9PM",
    sunday: "9AM - 9PM"
  )
  
  static let example3 = Event(
    id: "3",
    startTime: "18:00:00",
    endTime: "21:00:00",
    ratings: 4.8,
    latitude: 25.77542312073535,
    longitude: -80.18616744670095,
    image: "",
    location: "Bayfront Park",
    title: "Bayfront Park Hangout",
    duration: "3-4 hours",
    address: "301 Biscayne Blvd, Miami, FL 33132",
    monday: "9AM - 9PM",
    tuesday: "9AM - 9PM",
    wednesday: "9AM - 9PM",
    thursday: "9AM - 9PM",
    friday: "9AM - 9PM",
    saturday: "9AM - 9PM",
    sunday: "9AM - 9PM"
  )
}
