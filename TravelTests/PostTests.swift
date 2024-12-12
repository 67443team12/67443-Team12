//
//  PostTests.swift
//  TravelTests
//
//  Created by Emma Shi on 12/4/24.
//

import XCTest
import Foundation

@testable import Travel

final class PostTests: XCTestCase {
	func testPostInitalization() {
    // Create an instance of the Post model
		let post = Post(
			id: "12345",
			title: "Sample Post",
			time: "2024-12-01",
			content: "This is a sample post for testing.",
			userId: "user123",
			userName: "John Doe",
			userPhoto: "https://example.com/photo.jpg",
			ifBookmarked: true,
			comments: [],
			photo: "https://example.com/image.jpg"
		)
		
    // Ensure the instance is not nil
		XCTAssertNotNil(post)
    
    // Validate the individual properties of the Post object
		XCTAssertEqual(post.id, "12345")
		XCTAssertEqual(post.title, "Sample Post")
		XCTAssertEqual(post.time, "2024-12-01")
		XCTAssertEqual(post.content, "This is a sample post for testing.")
		XCTAssertEqual(post.userId, "user123")
		XCTAssertEqual(post.userName, "John Doe")
		XCTAssertEqual(post.userPhoto, "https://example.com/photo.jpg")
		XCTAssertEqual(post.ifBookmarked, true)
		XCTAssertEqual(post.comments, [])
		XCTAssertEqual(post.photo, "https://example.com/image.jpg")
	}
	
	func testPostEquality() {
    // Create two Post objects with the same data
		let post1 = Post(
			id: "12345",
			title: "Sample Post",
			time: "2024-12-01",
			content: "",
			userId: "",
			userName: "",
			userPhoto: "",
			ifBookmarked: false,
			comments: []
		)
		
		let post2 = Post(
			id: "12345",
			title: "Sample Post",
			time: "2024-12-01",
			content: "",
			userId: "",
			userName: "",
			userPhoto: "",
			ifBookmarked: false,
			comments: []
		)
		
    // Validate that the two posts are considered equal
		XCTAssertEqual(post1, post2)
	}
	
	func testPostComparison() {
    // Create two posts with different times
		let smaller = Post(
			id: "12345",
			title: "Earlier Post",
			time: "2024-12-01",
			content: "",
			userId: "",
			userName: "",
			userPhoto: "",
			ifBookmarked: false,
			comments: []
		)
		
		let bigger = Post(
			id: "67890",
			title: "Later Post",
			time: "2024-12-02",
			content: "",
			userId: "",
			userName: "",
			userPhoto: "",
			ifBookmarked: false,
			comments: []
		)
		
    // Validate that posts are ordered correctly by time
		XCTAssertTrue(smaller < bigger)
		XCTAssertFalse(bigger < smaller)
	}
	
	func testDecodableInitializer() throws {
    // JSON representation of a Post
		let json = """
		{
			"id": "12345",
			"title": "Test Title",
			"time": "2024-12-01",
			"content": "Test content.",
			"userId": "user123",
			"userName": "John Doe",
			"userPhoto": "https://example.com/photo.jpg",
			"ifBookmarked": true,
			"comments": [],
			"photo": "https://example.com/image.jpg"
		}
		"""
		let data = json.data(using: .utf8)!
		let decoder = JSONDecoder()
    
    // Decode the JSON into a Post object
		let post = try decoder.decode(Post.self, from: data)

    // Validate the decoded Post properties
		XCTAssertEqual(post.id, "12345")
		XCTAssertEqual(post.title, "Test Title")
		XCTAssertEqual(post.time, "2024-12-01")
		XCTAssertEqual(post.content, "Test content.")
		XCTAssertEqual(post.userId, "user123")
		XCTAssertEqual(post.userName, "John Doe")
		XCTAssertEqual(post.userPhoto, "https://example.com/photo.jpg")
		XCTAssertEqual(post.ifBookmarked, true)
		XCTAssertEqual(post.comments.count, 0)
		XCTAssertEqual(post.photo, "https://example.com/image.jpg")
	}
	
	func testTimeFormatting() {
    // Create a Post object with a specific time
		let post = Post(
			id: "12345",
			title: "Sample Post",
			time: "2024-12-01",
			content: "",
			userId: "",
			userName: "",
			userPhoto: "",
			ifBookmarked: false,
			comments: []
		)
		
    // Validate that the formatted time matches the expected format
		XCTAssertEqual(post.formattedTime, "Dec 1, 2024")
	}
}
