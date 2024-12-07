//
//  UserRepoTests.swift
//  Travel
//
//  Created by k mao on 12/6/24.
//

import XCTest
@testable import Travel

class UserRepositoryTests: XCTestCase {
    var userRepository: UserRepository!
    
    override func setUp() {
        super.setUp()
        userRepository = UserRepository()
        userRepository.users = [] // Start with an empty users array
    }
    
    func testFetchUsers() {
        // Simulate Firebase data
        let mockUser = User(
            id: "123",
            name: "Test User",
            photo: "test-photo-url",
            Posts: [],
            Bookmarks: [],
            Trips: [],
            Friends: [],
            Requests: []
        )
        
        // Replace Firestore call with mock data
        userRepository.users = [mockUser]
        
        XCTAssertEqual(userRepository.users.count, 1)
        XCTAssertEqual(userRepository.users[0].name, "Test User")
    }
  
  func testToggleBookmark() {
      let user = User(
          id: "123",
          name: "Test User",
          photo: "test-photo-url",
          Posts: [],
          Bookmarks: [],
          Trips: [],
          Friends: [],
          Requests: []
      )
      userRepository.users = [user]
      
      // Add a bookmark
      userRepository.toggleUserBookmark(postId: "post1", userId: "123")
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          XCTAssertTrue(self.userRepository.users[0].Bookmarks.contains("post1"))
          
          // Remove the bookmark
          self.userRepository.toggleUserBookmark(postId: "post1", userId: "123")
          
          // Wait again
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              XCTAssertFalse(self.userRepository.users[0].Bookmarks.contains("post1"))
          }
      }
  }
  
  
  
  
  
  
  
}

