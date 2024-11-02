//
//  Location.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

class Location: Identifiable, Codable, Comparable {
	var id: String
	var name: String
	var latitude: Double
	var longitude: Double
	var address: String
	var duration: String
	var ratings: Double
	var Monday: String
	var Tuesday: String
	var Wednesday: String
	var Thursday: String
	var Friday: String
	var Saturday: String
	var Sunday: String
	var image: String
	var description: String
	
	enum CodingKeys: String, CodingKey {
		case id = "locationId"
		case name = "locationName"
		case latitude
		case longitude
		case address
		case duration = "estimateDuration"
		case ratings
		case Monday
		case Tuesday
		case Wednesday
		case Thursday
		case Friday
		case Saturday
		case Sunday
		case image
		case description
	}
	
	static func < (lhs: Location, rhs: Location) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: Location, rhs: Location) -> Bool {
		lhs.id == rhs.id
	}
}
