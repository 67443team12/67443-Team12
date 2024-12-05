//
//  CommentTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import Foundation
import XCTest

@testable import Travel

final class CommentTests: XCTestCase {
	func testComment() {
		let comment1 = Comment(
			id: "1",
			userId: "Alice215",
			userName: "Alice",
			userPhoto: "",
			content: "I love this place!"
		)
		
		let comment2 = Comment(
			id: "1",
			userId: "Alice215",
			userName: "Alice",
			userPhoto: "",
			content: "I love this place!"
		)
		
		let comment3 = Comment(
			id: "2",
			userId: "Bob1241",
			userName: "Bob",
			userPhoto: "",
			content: "Your photos are amazing!"
		)
		
		XCTAssertNotNil(comment1)
		XCTAssertNotNil(comment2)
		XCTAssertNotNil(comment3)
		
		XCTAssertEqual(comment1.id, "1")
		XCTAssertEqual(comment1.userId, "Alice215")
		XCTAssertEqual(comment1.userName, "Alice")
		XCTAssertEqual(comment1.userPhoto, "")
		XCTAssertEqual(comment1.content, "I love this place!")
		
		XCTAssertTrue(comment1 == comment2)
		XCTAssertFalse(comment1 == comment3)
		
		XCTAssertTrue(comment1 < comment3)
		XCTAssertFalse(comment3 < comment1)
	}
}
