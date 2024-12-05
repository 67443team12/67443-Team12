//
//  DayTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import XCTest

@testable import Travel

final class DayTests: XCTestCase {
	func testDay() {
		let day1 = Day(
			id: "1",
			date: "2024-03-05",
			events: []
		)
		
		let day2 = Day(
			id: "2",
			date: "2024-03-06",
			events: []
		)
		
		let day3 = Day(
			id: "1",
			date: "2024-03-05",
			events: []
		)
		
		XCTAssertNotNil(day1)
		XCTAssertNotNil(day2)
		XCTAssertNotNil(day3)
		
		XCTAssertEqual(day1.id, "1")
		XCTAssertEqual(day1.date, "2024-03-05")
		XCTAssertEqual(day1.events, [])
		
		XCTAssertTrue(day1 < day2)
		XCTAssertFalse(day1 == day2)
		
		XCTAssertTrue(day1 == day3)
		XCTAssertFalse(day1 < day3)
		
	}
	
	func testDayDateConvert() {
		let day = Day(
			id: "1",
			date: "2024-03-05",
			events: []
		)
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
		XCTAssertEqual(day.dateAsDateObj, dateFormatter.date(from: "2024-03-05"))
		XCTAssertEqual(day.formattedDate, "Mar 5, 2024")
	}
}
