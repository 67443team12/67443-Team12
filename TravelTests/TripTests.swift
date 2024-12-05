//
//  TripTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import XCTest

@testable import Travel

final class TripTests: XCTestCase {
	func testTrip() {
		let trip1 = Trip(
			id: "1",
			name: "Miami",
			startDate: "2024-03-05",
			endDate: "2024-03-08",
			photo: "",
			color: "blue",
			days: [Day.example1, Day.example2],
			travelers: [SimpleUser.alice]
		)
		
		XCTAssertNotNil(trip1)
		XCTAssertEqual(trip1.id, "1")
		XCTAssertEqual(trip1.name, "Miami")
		XCTAssertEqual(trip1.startDate, "2024-03-05")
		XCTAssertEqual(trip1.endDate, "2024-03-08")
		XCTAssertEqual(trip1.photo, "")
		XCTAssertEqual(trip1.color, "blue")
		XCTAssertEqual(trip1.days, [Day.example1, Day.example2])
		XCTAssertEqual(trip1.travelers, [SimpleUser.alice])
		
		let trip2 = Trip(
			id: "1",
			name: "Miami",
			startDate: "2024-03-05",
			endDate: "2024-03-08",
			photo: "",
			color: "blue",
			days: [Day.example1, Day.example2],
			travelers: [SimpleUser.alice]
		)
		
		XCTAssertTrue(trip1 == trip2)
		
		let trip3 = Trip(
			id: "121351",
			name: "Seattle",
			startDate: "2024-08-12",
			endDate: "2024-08-15",
			photo: "",
			color: "red",
			days: [],
			travelers: [SimpleUser.alice]
		)
		
		XCTAssertFalse(trip1 == trip3)
		XCTAssertTrue(trip3 > trip1)
	}
	
	func testTripDateConvert() {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
		let trip = Trip(
			id: "1",
			name: "Miami",
			startDate: "2024-03-05",
			endDate: "2024-03-08",
			photo: "",
			color: "blue",
			days: [Day.example1, Day.example2],
			travelers: [SimpleUser.alice]
		)
		
		XCTAssertEqual(trip.startDateAsDate, dateFormatter.date(from: "2024-03-05"))
		XCTAssertEqual(trip.endDateAsDate, dateFormatter.date(from: "2024-03-08"))
		XCTAssertEqual(trip.formattedStartDate, "Mar 5, 2024")
		XCTAssertEqual(trip.formattedEndDate, "Mar 8, 2024")
	}
}
