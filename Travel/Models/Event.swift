//
//  Event.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Comparable, Codable {
	var id: UUID
	var locationId: String
	var locationName: String
	var latitude: Double
	var longitude: Double
	var address: String
	var startTime: String
	var endTime: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case locationId
		case locationName
		case latitude
		case longitude
		case address
		case startTime
		case endTime
	}
	
	static func < (lhs: Event, rhs: Event) -> Bool {
		lhs.startTime < rhs.startTime
	}
	
	static func == (lhs: Event, rhs: Event) -> Bool {
		lhs.id < rhs.id
	}
  
  static let example1 = Event(id: UUID(),
                              locationId: "1234A",
                              locationName: "Bayfront Park",
                              latitude: 25.77542312073535,
                              longitude: -80.18616744670095,
                              address: "301 Biscayne Blvd, Miami, FL 33132",
                              startTime: "13:00:00",
                              endTime: "14:00:00")
  
  static let example2 = Event(id: UUID(),
                              locationId: "1234A",
                              locationName: "Bayfront Park",
                              latitude: 25.77542312073535,
                              longitude: -80.18616744670095,
                              address: "301 Biscayne Blvd, Miami, FL 33132",
                              startTime: "15:00:00",
                              endTime: "17:00:00")
  
  static let example3 = Event(id: UUID(),
                              locationId: "1234A",
                              locationName: "Bayfront Park",
                              latitude: 25.77542312073535,
                              longitude: -80.18616744670095,
                              address: "301 Biscayne Blvd, Miami, FL 33132",
                              startTime: "18:00:00",
                              endTime: "21:00:00")
}
