//
//  Trip.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import Foundation

struct Trip: Identifiable, Codable {
  var id: String
  var name: String
  var startDate: String
  var endDate: String
  var photo: String
  var color: String
  var days: [Day]
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case startDate
    case endDate
    case photo
    case color
    case days
  }
}
