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
    // Create instances of the User model
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
		
    // Ensure the User instance is successfully created
		XCTAssertNotNil(user)
    
    // Verify all properties of the User instance
		XCTAssertEqual(user.id, "123")
		XCTAssertEqual(user.name, "Emma")
		XCTAssertEqual(user.photo, "test")
		XCTAssertEqual(user.Posts, [])
		XCTAssertEqual(user.Bookmarks, [])
		XCTAssertEqual(user.Trips, [])
		XCTAssertEqual(user.Friends, [])
		XCTAssertEqual(user.Requests, [])
    
    // Test equality between identical User instances
		XCTAssertTrue(user == user1)
    
    // Test comparison between User instances
		XCTAssertTrue(user > user2)
	}
	
	func testToDictionary() {
    // Create a sample User instance with data
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
		
    // Convert the User instance to a dictionary
		let dictionary = user.toDictionary()
		
    // Verify the dictionary contains all expected data
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
