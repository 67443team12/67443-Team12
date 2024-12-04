//
//  SimpleUserTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import XCTest
@testable import Travel

final class SimpleUserTests: XCTestCase {
	func testSimpleUser() {
		let sUser1 = SimpleUser(
			id: "Alice215",
			name: "Alice",
			photo: ""
		)
		
		let sUser2 = SimpleUser(
			id: "Bob1241",
			name: "Bob",
			photo: ""
		)
		
		let sUser3 = SimpleUser(
			id: "Alice215",
			name: "Alice",
			photo: ""
		)
		
		XCTAssertNotNil(sUser1)
		XCTAssertNotNil(sUser2)
		XCTAssertNotNil(sUser3)
		
		XCTAssertEqual(sUser1.id, "Alice215")
		XCTAssertEqual(sUser1.name, "Alice")
		XCTAssertEqual(sUser1.photo, "")
		
		XCTAssertTrue(sUser1 == sUser3)
		XCTAssertFalse(sUser1 == sUser2)
		
		XCTAssertTrue(sUser1 < sUser2)
		XCTAssertFalse(sUser2 < sUser1)
	}
	
	func testToDictionary() {
		let sUser = SimpleUser(
			id: "Alice215",
			name: "Alice",
			photo: "https://example.com/alice.png"
		)
		
		let dictionary = sUser.toDictionary()
		
		XCTAssertEqual(dictionary["userId"] as? String, "Alice215")
		XCTAssertEqual(dictionary["name"] as? String, "Alice")
		XCTAssertEqual(dictionary["photo"] as? String, "https://example.com/alice.png")
	}
}
