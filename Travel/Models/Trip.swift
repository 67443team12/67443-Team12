//
//  Trip.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import Foundation
import SwiftUI

struct Trip: Identifiable, Codable, Comparable {
  var id: String
  var tripName: String
  var startDate: String
  var endDate: String
  var photo: String
  var color: String
	var days: [Day]
	var travelers: [SimpleUser]
  
  enum CodingKeys: String, CodingKey {
    case id = "tripId"
    case tripName
    case startDate
    case endDate
    case photo
    case color
		case days
		case travelers
  }
	
	static func < (lhs: Trip, rhs: Trip) -> Bool {
		lhs.startDate < rhs.startDate
	}
	
	static func == (lhs: Trip, rhs: Trip) -> Bool {
		lhs.id == rhs.id
	}
}
