//
//  Location.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct Location: Identifiable, Codable, Comparable, Hashable {
	var id: String
	var name: String
	var latitude: Double
	var longitude: Double
	var address: String
	var duration: String
	var ratings: Double
  var sunday: String
  var monday: String
  var tuesday: String
  var wednesday: String
  var thursday: String
  var friday: String
  var saturday: String
	var image: String
	var description: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case latitude
		case longitude
		case address
		case duration
		case ratings
		case monday
		case tuesday
		case wednesday
		case thursday
		case friday
		case saturday
		case sunday
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
