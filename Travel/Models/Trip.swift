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
  var name: String
  var startDate: String
  var endDate: String
  var photo: String
  var color: String
	var days: [Day]
	var travelers: [SimpleUser]
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
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
	
	var startDateAsDate: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.date(from: startDate)
	}
	
	static let example = Trip(
		id: "1",
		name: "Miami",
		startDate: "2024-03-05",
		endDate: "2024-03-08",
		photo: "",
		color: "blue",
    days: [Day.example1, Day.example2, Day.example3, Day.example4],
		travelers: [SimpleUser.bob]
	)
}
