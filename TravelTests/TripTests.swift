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
    // Create an instance of the Trip model
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
		
    // Ensure the instance is successfully created
		XCTAssertNotNil(trip1)
    
    // Verify all properties of the trip instance
		XCTAssertEqual(trip1.id, "1")
		XCTAssertEqual(trip1.name, "Miami")
		XCTAssertEqual(trip1.startDate, "2024-03-05")
		XCTAssertEqual(trip1.endDate, "2024-03-08")
		XCTAssertEqual(trip1.photo, "")
		XCTAssertEqual(trip1.color, "blue")
		XCTAssertEqual(trip1.days, [Day.example1, Day.example2])
		XCTAssertEqual(trip1.travelers, [SimpleUser.alice])
		
    // Create another instance with the same data
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
		
    // Test equality between identical trips
		XCTAssertTrue(trip1 == trip2)
		
    // Create a different trip instance
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
		
    // Ensure the trips are not considered equal
		XCTAssertFalse(trip1 == trip3)
    
    // Test comparison between trips (by startDate)
		XCTAssertTrue(trip3 > trip1)
	}
	
	func testTripDateConvert() {
    // Create a date formatter to match the date format in the Trip model
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
    // Create an instance of the Trip model
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
		
    // Validate the conversion of `startDate` and `endDate` to `Date` objects
		XCTAssertEqual(trip.startDateAsDate, dateFormatter.date(from: "2024-03-05"))
		XCTAssertEqual(trip.endDateAsDate, dateFormatter.date(from: "2024-03-08"))
		
    // Verify the formatted string representations of the start and end dates
    XCTAssertEqual(trip.formattedStartDate, "Mar 5, 2024")
		XCTAssertEqual(trip.formattedEndDate, "Mar 8, 2024")
	}
}
