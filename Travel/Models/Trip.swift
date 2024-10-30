//
//  Trip.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import Foundation

struct Trip: Identifiable, Codable {
  var id: String
  var tripName: String
  var startDate: String
  var endDate: String
  var photo: String
  var color: String
  
  enum CodingKeys: String, CodingKey {
    case id = "tripId"
    case tripName
    case startDate
    case endDate
    case photo
    case color
  }
}
