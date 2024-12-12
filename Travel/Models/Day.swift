//
//  Day.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct Day: Identifiable, Comparable, Codable {
  // Properties
  var id: String
	var date: String
	var events: [Event]
	
  // Coding Keys
	enum CodingKeys: String, CodingKey {
		case id
		case date
		case events
	}
	
  // Comparable Protocol
	static func < (lhs: Day, rhs: Day) -> Bool {
		lhs.date < rhs.date
	}
	
	static func == (lhs: Day, rhs: Day) -> Bool {
		lhs.id == rhs.id
	}
	
  // Date Conversion Helpers
	var dateAsDateObj: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.date(from: date)
	}
	
  // Formatted Date for Display
	var formattedDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM d, yyyy"
		return dateFormatter.string(from: dateAsDateObj!)
	}
  
  // Example Days
  static let example1 = Day(
    id: "1", 
    date: "2024-03-05", 
    events: [Event.example1, Event.example2, Event.example3]
  )
  
  static let example2 = Day(
    id: "2",
    date: "2024-03-06",
    events: []
  )
  
  static let example3 = Day(
    id: "3", 
    date: "2024-03-07",
    events: []
  )
  
  static let example4 = Day(
    id: "4",
    date: "2024-03-08",
    events: []
  )
}
