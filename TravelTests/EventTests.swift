//
//  EventTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import XCTest

@testable import Travel

final class EventTests: XCTestCase {
	func testEvent() {
		let event = Event(
			id: "1",
			startTime: "13:00",
			endTime: "14:00",
			ratings: 4.8,
			latitude: 25.77542312073535,
			longitude: -80.18616744670095,
			image: "example.com/image",
			location: "Bayfront Park",
			title: "Bayfront Park Hangout",
			duration: "3-4 hours",
			address: "301 Biscayne Blvd, Miami, FL 33132",
			monday: "9AM - 9PM",
			tuesday: "9AM - 9PM",
			wednesday: "9AM - 9PM",
			thursday: "9AM - 9PM",
			friday: "9AM - 9PM",
			saturday: "9AM - 9PM",
			sunday: "9AM - 9PM"
		)
		
		XCTAssertNotNil(event)
		XCTAssertEqual(event.id, "1")
		XCTAssertEqual(event.startTime, "13:00")
		XCTAssertEqual(event.endTime, "14:00")
		XCTAssertEqual(event.ratings, 4.8)
		XCTAssertEqual(event.latitude, 25.77542312073535)
		XCTAssertEqual(event.longitude, -80.18616744670095)
		XCTAssertEqual(event.image, "example.com/image")
		XCTAssertEqual(event.location, "Bayfront Park")
		XCTAssertEqual(event.title, "Bayfront Park Hangout")
		XCTAssertEqual(event.duration, "3-4 hours")
		XCTAssertEqual(event.address, "301 Biscayne Blvd, Miami, FL 33132")
		XCTAssertEqual(event.monday, "9AM - 9PM")
		XCTAssertEqual(event.tuesday, "9AM - 9PM")
		XCTAssertEqual(event.wednesday, "9AM - 9PM")
		XCTAssertEqual(event.thursday, "9AM - 9PM")
		XCTAssertEqual(event.friday, "9AM - 9PM")
		XCTAssertEqual(event.saturday, "9AM - 9PM")
		XCTAssertEqual(event.sunday, "9AM - 9PM")
		
		let event1 = Event(
			id: "1",
			startTime: "13:00",
			endTime: "14:00",
			ratings: 4.8,
			latitude: 25.77542312073535,
			longitude: -80.18616744670095,
			image: "example.com/image",
			location: "Bayfront Park",
			title: "Bayfront Park Hangout",
			duration: "3-4 hours",
			address: "301 Biscayne Blvd, Miami, FL 33132",
			monday: "9AM - 9PM",
			tuesday: "9AM - 9PM",
			wednesday: "9AM - 9PM",
			thursday: "9AM - 9PM",
			friday: "9AM - 9PM",
			saturday: "9AM - 9PM",
			sunday: "9AM - 9PM"
		)
		
		XCTAssertNotNil(event1)
		XCTAssertTrue(event == event1)
		
		let event2 = Event(
			id: "1",
			startTime: "16:00",
			endTime: "18:00",
			ratings: 4.8,
			latitude: 25.77542312073535,
			longitude: -80.18616744670095,
			image: "example.com/image",
			location: "Bayfront Park",
			title: "Bayfront Park Hangout",
			duration: "3-4 hours",
			address: "301 Biscayne Blvd, Miami, FL 33132",
			monday: "9AM - 9PM",
			tuesday: "9AM - 9PM",
			wednesday: "9AM - 9PM",
			thursday: "9AM - 9PM",
			friday: "9AM - 9PM",
			saturday: "9AM - 9PM",
			sunday: "9AM - 9PM"
		)
		
		XCTAssertNotNil(event2)
		XCTAssertTrue(event < event2)
	}
	
	func testToDictionary() {
		let event = Event(
			id: "1",
			startTime: "13:00",
			endTime: "14:00",
			ratings: 4.8,
			latitude: 25.77542312073535,
			longitude: -80.18616744670095,
			image: "example.com/image",
			location: "Bayfront Park",
			title: "Bayfront Park Hangout",
			duration: "3-4 hours",
			address: "301 Biscayne Blvd, Miami, FL 33132",
			monday: "9AM - 9PM",
			tuesday: "9AM - 9PM",
			wednesday: "9AM - 9PM",
			thursday: "9AM - 9PM",
			friday: "9AM - 9PM",
			saturday: "9AM - 9PM",
			sunday: "9AM - 9PM"
		)
		
		let dictionary = event.toDictionary()
		
		XCTAssertNotNil(dictionary)
		XCTAssertEqual(dictionary["id"] as? String, "1")
		XCTAssertEqual(dictionary["startTime"] as? String, "13:00")
		XCTAssertEqual(dictionary["endTime"] as? String, "14:00")
		XCTAssertEqual(dictionary["ratings"] as? Double, 4.8)
		XCTAssertEqual(dictionary["latitude"] as? Double, 25.77542312073535)
		XCTAssertEqual(dictionary["longitude"] as? Double, -80.18616744670095)
		XCTAssertEqual(dictionary["image"] as? String, "example.com/image")
		XCTAssertEqual(dictionary["location"] as? String, "Bayfront Park")
		XCTAssertEqual(dictionary["title"] as? String, "Bayfront Park Hangout")
		XCTAssertEqual(dictionary["duration"] as? String, "3-4 hours")
		XCTAssertEqual(dictionary["address"] as? String, "301 Biscayne Blvd, Miami, FL 33132")
		XCTAssertEqual(dictionary["monday"] as? String, "9AM - 9PM")
		XCTAssertEqual(dictionary["tuesday"] as? String, "9AM - 9PM")
		XCTAssertEqual(dictionary["wednesday"] as? String, "9AM - 9PM")
		XCTAssertEqual(dictionary["thursday"] as? String, "9AM - 9PM")
		XCTAssertEqual(dictionary["friday"] as? String, "9AM - 9PM")
		XCTAssertEqual(dictionary["saturday"] as? String, "9AM - 9PM")
		XCTAssertEqual(dictionary["sunday"] as? String, "9AM - 9PM")
	}
	
	func testDateConvert() {
		let event = Event(
			id: "1",
			startTime: "13:00",
			endTime: "14:00",
			ratings: 4.8,
			latitude: 25.77542312073535,
			longitude: -80.18616744670095,
			image: "example.com/image",
			location: "Bayfront Park",
			title: "Bayfront Park Hangout",
			duration: "3-4 hours",
			address: "301 Biscayne Blvd, Miami, FL 33132",
			monday: "9AM - 9PM",
			tuesday: "9AM - 9PM",
			wednesday: "9AM - 9PM",
			thursday: "9AM - 9PM",
			friday: "9AM - 9PM",
			saturday: "9AM - 9PM",
			sunday: "9AM - 9PM"
		)
		
		XCTAssertNotNil(event.startTimeAsDate())
		XCTAssertNotNil(event.endTimeAsDate())
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm"
		XCTAssertEqual(event.startTimeAsDate(), dateFormatter.date(from: "13:00"))
		XCTAssertEqual(event.endTimeAsDate(), dateFormatter.date(from: "14:00"))
	}
	
}
