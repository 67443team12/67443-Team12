//
//  UserRepoTests.swift
//  Travel
//
//  Created by Kailan Mao on 12/6/24.
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
    
  // Test fetching users from the repository
  func testFetchUsers() {
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
    userRepository.users = [mockUser]
    XCTAssertEqual(userRepository.users.count, 1)
    XCTAssertEqual(userRepository.users[0].name, "Test User")
  }
  
  // Test toggling a bookmark for a user
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
    userRepository.toggleUserBookmark(postId: "post1", userId: "123")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(self.userRepository.users[0].Bookmarks.contains("post1"))
      self.userRepository.toggleUserBookmark(postId: "post1", userId: "123")
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        XCTAssertFalse(self.userRepository.users[0].Bookmarks.contains("post1"))
      }
    }
  }
  
  // Test if a user can leave a trip
  func testLeaveTrip() {
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
    userRepository.users = [mockUser]
    tripRepository.trips = [mockTrip]
    userRepository.leaveTrip(tripId: "123", userId: "123")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(!self.userWithId(id: "123", users: self.userRepository.users).Trips.contains("123"))
    }
  }
  
  // Test deleting a friend
  func testDeleteFriend() {
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
    userRepository.users = [mockUser1, mockUser2]
    userRepository.deleteFriend(currUser: mockUser1, friend: mockUser2)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(!self.userWithId(id: "123", users: self.userRepository.users).Friends.contains("321"))
      XCTAssertTrue(!self.userWithId(id: "321", users: self.userRepository.users).Friends.contains("123"))
    }
  }
  
  // Test deleting a friend
  func testAddTripToUser() {
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
    userRepository.users = [mockUser]
    tripRepository.trips = [mockTrip]
    userRepository.addTripToUser(currUser: mockUser, newTripId: "123")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(self.userWithId(id: "123", users: self.userRepository.users).Trips.contains("123"))
    }
  }
  
  // Test sending a friend request
  func testSendRequest() {
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
    userRepository.users = [mockUser1, mockUser2]
    userRepository.sendRequest(currUser: mockUser1, request: mockUser2)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(self.userWithId(id: "321", users: self.userRepository.users).Requests.contains("123"))
    }
  }
  
  // Test accepting a friend request
  func testAcceptRequest() {
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
    userRepository.users = [mockUser1, mockUser2]
    userRepository.acceptRequest(currUser: mockUser1, request: mockUser2)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(self.userWithId(id: "123", users: self.userRepository.users).Friends.contains("321"))
      XCTAssertTrue(self.userWithId(id: "321", users: self.userRepository.users).Friends.contains("123"))
    }
  }
  
  // Test updating a user's photo URL
  func testUpdateUserPhotoURL() {
    let expectation = XCTestExpectation(description: "Wait for photo URL update")
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
    userRepository.users = [user]
    let newPhotoURL = "updated-photo-url"
    userRepository.updateUserPhotoURL(userId: "123", photoURL: newPhotoURL) { success in
      XCTAssertTrue(success, "Photo URL update should succeed")
      DispatchQueue.main.async {
        XCTAssertEqual(self.userRepository.users.first(where: { $0.id == "123" })?.photo, newPhotoURL, "Photo URL should match the updated value")
        expectation.fulfill()
      }
    }
  }
  
  // Test uploading a user's profile photo to storage and updating the photo URL
  func testUploadUserPhoto() {
    let expectation = XCTestExpectation(description: "Wait for photo URL update")
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
    userRepository.users = [user]
    let newPhotoURL = "updated-photo-url"
    userRepository.uploadPhotoToStorage(imageData: self.mockImageData, userId: "123") { success in
      XCTAssertTrue(success != nil, "Photo URL update should succeed")
      DispatchQueue.main.async {
        XCTAssertTrue(self.userRepository.users.first(where: { $0.id == "123" })?.photo != nil, "Photo URL should be nonempty")
        expectation.fulfill()
      }
    }
  }
  
  // Test searching users by ID
  func testSearchById() {
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
    userRepository.users = [mockUser]
    userRepository.searchById(searchText: "123")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      XCTAssertTrue(self.userRepository.filteredUsers.count == 1)
    }
  }
  
  // Helper function to find a user by ID
  func userWithId(id: String, users: [User]) -> User {
    guard let user = users.first(where: { $0.id == id }) else {
      preconditionFailure("User with ID \(id) not found.")
    }
    return user
  }
}

