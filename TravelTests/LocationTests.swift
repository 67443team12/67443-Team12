//
//  LocationTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import XCTest
import Foundation

@testable import Travel

final class LocationTests: XCTestCase {
	
	func testLocation() {
		let location = Location(
			id: "111111",
			name: "Golden Gate Bridge",
			latitude: 37.8199,
			longitude: -122.4783,
			address: "Golden Gate Bridge, San Francisco, CA 94129",
			duration: "2-3 hours",
			ratings: 4.6,
			sunday: "All Day",
			monday: "All Day",
			tuesday: "All Day",
			wednesday: "All Day",
			thursday: "All Day",
			friday: "All Day",
			saturday: "All Day",
			image: "golden_gate_bridge",
			description: "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean."
		)
		
		// Initialization
		XCTAssertNotNil(location)
		XCTAssertEqual(location.id, "111111")
		XCTAssertEqual(location.name, "Golden Gate Bridge")
		XCTAssertEqual(location.latitude, 37.8199)
		XCTAssertEqual(location.longitude, -122.4783)
		XCTAssertEqual(location.address, "Golden Gate Bridge, San Francisco, CA 94129")
		XCTAssertEqual(location.duration, "2-3 hours")
		XCTAssertEqual(location.ratings, 4.6)
		XCTAssertEqual(location.sunday, "All Day")
		XCTAssertEqual(location.monday, "All Day")
		XCTAssertEqual(location.tuesday, "All Day")
		XCTAssertEqual(location.wednesday, "All Day")
		XCTAssertEqual(location.thursday, "All Day")
		XCTAssertEqual(location.friday, "All Day")
		XCTAssertEqual(location.saturday, "All Day")
		XCTAssertEqual(location.image, "golden_gate_bridge")
		XCTAssertEqual(location.description, "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.")
		
		// Equal
		let location1 = Location(
			id: "111111",
			name: "Golden Gate Bridge",
			latitude: 37.8199,
			longitude: -122.4783,
			address: "Golden Gate Bridge, San Francisco, CA 94129",
			duration: "2-3 hours",
			ratings: 4.6,
			sunday: "All Day",
			monday: "All Day",
			tuesday: "All Day",
			wednesday: "All Day",
			thursday: "All Day",
			friday: "All Day",
			saturday: "All Day",
			image: "golden_gate_bridge",
			description: "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean."
		)
		
		XCTAssertNotNil(location1)
		XCTAssertTrue(location == location1)
		
		// Comparison
		let location2 = Location(
			id: "102935",
			name: "American Museum of Natural History",
			latitude: 40.781372619162916,
			longitude: -73.97396139707573,
			address: "200 Central Park W, New York, NY 10024",
			duration: "2-3 hours",
			ratings: 4.5,
			sunday: "10:00AM - 5:30PM",
			monday: "10:00AM - 5:30PM",
			tuesday: "10:00AM - 5:30PM",
			wednesday: "10:00AM - 5:30PM",
			thursday: "10:00AM - 5:30PM",
			friday: "10:00AM - 5:30PM",
			saturday: "10:00AM - 5:30PM",
			image: "",
			description: "From dinosaurs to outer space & everything in between, this huge museum showcases natural wonders."
		)
		
		XCTAssertNotNil(location2)
		XCTAssertTrue(location > location2)
	}
}
