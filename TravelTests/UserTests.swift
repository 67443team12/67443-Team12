//
//  UserTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import Foundation
import XCTest

@testable import Travel

final class UserTests: XCTestCase {
	func testUser() {
		let user: User = User(
			id: "123",
			name: "Emma",
			photo: "test",
			Posts: [],
			Bookmarks: [],
			Trips: [],
			Friends: [],
			Requests: []
		)
		
		let user1: User = User(
			id: "123",
			name: "Emma",
			photo: "test",
			Posts: [],
			Bookmarks: [],
			Trips: [],
			Friends: [],
			Requests: []
		)
		
		let user2: User = User(
			id: "999",
			name: "Bob",
			photo: "test",
			Posts: [],
			Bookmarks: [],
			Trips: [],
			Friends: [],
			Requests: []
		)
		
		XCTAssertNotNil(user)
		XCTAssertEqual(user.id, "123")
		XCTAssertEqual(user.name, "Emma")
		XCTAssertEqual(user.photo, "test")
		XCTAssertEqual(user.Posts, [])
		XCTAssertEqual(user.Bookmarks, [])
		XCTAssertEqual(user.Trips, [])
		XCTAssertEqual(user.Friends, [])
		XCTAssertEqual(user.Requests, [])
		XCTAssertTrue(user == user1)
		XCTAssertTrue(user > user2)
	}
	
	func testToDictionary() {
		let user = User(
			id: "Alice215",
			name: "Alice",
			photo: "https://example.com/alice.png",
			Posts: ["post1", "post2"],
			Bookmarks: ["bookmark1"],
			Trips: ["trip1", "trip2"],
			Friends: ["friend1", "friend2"],
			Requests: ["request1"]
		)
		
		let dictionary = user.toDictionary()
		
		XCTAssertEqual(dictionary["id"] as? String, "Alice215")
		XCTAssertEqual(dictionary["name"] as? String, "Alice")
		XCTAssertEqual(dictionary["photo"] as? String, "https://example.com/alice.png")
		XCTAssertEqual(dictionary["Posts"] as? [String], ["post1", "post2"])
		XCTAssertEqual(dictionary["Bookmarks"] as? [String], ["bookmark1"])
		XCTAssertEqual(dictionary["Trips"] as? [String], ["trip1", "trip2"])
		XCTAssertEqual(dictionary["Friends"] as? [String], ["friend1", "friend2"])
		XCTAssertEqual(dictionary["Requests"] as? [String], ["request1"])
	}
}
