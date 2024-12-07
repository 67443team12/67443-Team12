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
  var tripRepository: TripRepository!
  var mockImageData: Data!
    
    override func setUp() {
        super.setUp()
        userRepository = UserRepository()
      tripRepository = TripRepository()
      mockImageData = "MockImageData".data(using: .utf8)
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
  
  func testLeaveTrip() {
    
    // Simulate Firebase data
    let mockUser = User(
        id: "123",
        name: "Test User",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: ["123"],
        Friends: [],
        Requests: []
    )
    let mockTrip = Trip(
        id: "123",
        name: "Test trip",
        startDate: "start",
        endDate: "end",
        photo: "photo",
        color: "red",
        days: [],
        travelers: []
    )
    
    // Replace Firestore call with mock data
    userRepository.users = [mockUser]
    tripRepository.trips = [mockTrip]
      
      // Add a bookmark
      userRepository.leaveTrip(tripId: "123", userId: "123")
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertTrue(!self.userWithId(id: "123", users: self.userRepository.users).Trips.contains("123"))
      }
  }
  
  
  func testDeleteFriend() {
    
    // Simulate Firebase data
    let mockUser1 = User(
        id: "123",
        name: "Test User 1",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: ["321"],
        Requests: []
    )
    let mockUser2 = User(
        id: "321",
        name: "Test User 2",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: ["123"],
        Requests: []
    )

    
    // Replace Firestore call with mock data
    userRepository.users = [mockUser1, mockUser2]
      
      // Add a bookmark
      userRepository.deleteFriend(currUser: mockUser1, friend: mockUser2)
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertTrue(!self.userWithId(id: "123", users: self.userRepository.users).Friends.contains("321"))
        XCTAssertTrue(!self.userWithId(id: "321", users: self.userRepository.users).Friends.contains("123"))
      }
  }
  
  func testAddTripToUser() {
    
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
    let mockTrip = Trip(
        id: "123",
        name: "Test trip",
        startDate: "start",
        endDate: "end",
        photo: "photo",
        color: "red",
        days: [],
        travelers: []
    )
    
    // Replace Firestore call with mock data
    userRepository.users = [mockUser]
    tripRepository.trips = [mockTrip]
      
      // Add a bookmark
    userRepository.addTripToUser(currUser: mockUser, newTripId: "123")
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertTrue(self.userWithId(id: "123", users: self.userRepository.users).Trips.contains("123"))
      }
  }
  
  func testSendRequest() {
    
    // Simulate Firebase data
    let mockUser1 = User(
        id: "123",
        name: "Test User 1",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: [],
        Requests: []
    )
    let mockUser2 = User(
        id: "321",
        name: "Test User 2",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: [],
        Requests: []
    )

    
    // Replace Firestore call with mock data
    userRepository.users = [mockUser1, mockUser2]
      
      // Add a bookmark
      userRepository.sendRequest(currUser: mockUser1, request: mockUser2)
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertTrue(self.userWithId(id: "321", users: self.userRepository.users).Requests.contains("123"))
      }
  }
  
  
  
  func testAcceptRequest() {
    
    // Simulate Firebase data
    let mockUser1 = User(
        id: "123",
        name: "Test User 1",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: [],
        Requests: ["321"]
    )
    let mockUser2 = User(
        id: "321",
        name: "Test User 2",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: [],
        Requests: []
    )

    
    // Replace Firestore call with mock data
    userRepository.users = [mockUser1, mockUser2]
      
      // Add a bookmark
      userRepository.acceptRequest(currUser: mockUser1, request: mockUser2)
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertTrue(self.userWithId(id: "123", users: self.userRepository.users).Friends.contains("321"))
        XCTAssertTrue(self.userWithId(id: "321", users: self.userRepository.users).Friends.contains("123"))
      }
  }
  
  func testUpdateUserPhotoURL() {
         let expectation = XCTestExpectation(description: "Wait for photo URL update")
         
         // Mock user data
         let user = User(
             id: "123",
             name: "Test User",
             photo: "original-photo-url",
             Posts: [],
             Bookmarks: [],
             Trips: [],
             Friends: [],
             Requests: []
         )
         
         userRepository.users = [user] // Add the mock user to the repository
         
         // Update photo URL
         let newPhotoURL = "updated-photo-url"
         userRepository.updateUserPhotoURL(userId: "123", photoURL: newPhotoURL) { success in
             XCTAssertTrue(success, "Photo URL update should succeed")
             
             // Verify the photo URL was updated
             DispatchQueue.main.async {
                 XCTAssertEqual(self.userRepository.users.first(where: { $0.id == "123" })?.photo, newPhotoURL, "Photo URL should match the updated value")
                 
                 // Fulfill the expectation once the assertions are done
                 expectation.fulfill()
             }
         }
         
     }
  
  
  func testSearchById() {
    
    // Simulate Firebase data
    let mockUser = User(
        id: "123",
        name: "Test User 1",
        photo: "test-photo-url",
        Posts: [],
        Bookmarks: [],
        Trips: [],
        Friends: [],
        Requests: []
    )


    
    // Replace Firestore call with mock data
    userRepository.users = [mockUser]
      
      // Add a bookmark
    userRepository.searchById(searchText: "123")
      
      // Give it time to update
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertTrue(self.userRepository.filteredUsers.count == 1)
      }
  }
  
  
  
  
  func userWithId(id: String, users: [User]) -> User {
      guard let user = users.first(where: { $0.id == id }) else {
          preconditionFailure("User with ID \(id) not found.")
      }
      return user
  }
  

  
  
  
}

