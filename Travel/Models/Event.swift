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
}
