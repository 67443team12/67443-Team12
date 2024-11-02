//
//  SimpleTrip.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct SimpleTrip: Identifiable, Codable, Comparable {
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
	
	static func < (lhs: SimpleTrip, rhs: SimpleTrip) -> Bool {
		lhs.startDate < rhs.startDate
	}
	
	static func == (lhs: SimpleTrip, rhs: SimpleTrip) -> Bool {
		lhs.id == rhs.id
	}
}
