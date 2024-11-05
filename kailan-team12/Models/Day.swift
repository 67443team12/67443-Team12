//
//  Day.swift
//  kailan-team12
//
//  Created by k mao on 11/4/24.
//

import Foundation

struct Day: Identifiable, Codable {
  var id: String
  var date: String
  var events: [Event]
  
  enum CodingKeys: String, CodingKey {
    case id
    case date
    case events
  }
}
