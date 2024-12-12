//
//  TripRepoTests.swift
//  Travel
//
//  Created by Kailan Mao on 12/6/24.
//

import XCTest
import Combine
@testable import Travel

class TripRepositoryTests: XCTestCase {
  var tripRepository: TripRepository!
  var cancellables: Set<AnyCancellable>!
  var mockImageData: Data!

  override func setUp() {
    super.setUp()
    tripRepository = TripRepository()
    tripRepository.trips = []
    cancellables = []
    mockImageData = "MockImageData".data(using: .utf8)
  }

  override func tearDown() {
    tripRepository = nil
    cancellables = nil
    super.tearDown()
  }

  // Test if a new trip can be added to the repository
  func testAddTrip() {
    let newTrip = Trip(
      id: "456",
      name: "New Trip",
      startDate: "2024-12-15",
      endDate: "2024-12-20",
      photo: "newPhoto",
      color: "green",
      days: [],
      travelers: []
    )
    let expectation = self.expectation(description: "Waiting for Firestore update")
    tripRepository.$trips
      .dropFirst()
      .sink { trips in
        if let addedTrip = trips.first(where: { $0.id == newTrip.id }) {
          XCTAssertEqual(addedTrip.id, "456", "The trip ID should match")
          XCTAssertEqual(addedTrip.name, "New Trip", "The trip name should match")
          XCTAssertEqual(addedTrip.startDate, "2024-12-15", "The start date should match")
          XCTAssertEqual(addedTrip.endDate, "2024-12-20", "The end date should match")
          XCTAssertEqual(addedTrip.photo, "newPhoto", "The photo should match")
          XCTAssertEqual(addedTrip.color, "green", "The color should match")
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)
    tripRepository.addTrip(newTrip)
    waitForExpectations(timeout: 5.0, handler: nil)
  }

  // Test if an event can be added to a trip's day
  func testAddEventToTrip() {
    let trip = Trip(
      id: "123",
      name: "Test Trip",
      startDate: "2024-12-06",
      endDate: "2024-12-10",
      photo: "testPhoto",
      color: "blue",
      days: [Day(id: "day1", date: "2024-12-06", events: [])],
      travelers: []
    )
    let event = Event(
      id: "event1",
      startTime: "10:00",
      endTime: "12:00",
      ratings: 5,
      latitude: 0.0,
      longitude: 0.0,
      image: "eventPhoto",
      location: "Test Location",
      title: "Test Event",
      duration: "2 hours",
      address: "Test Address",
      monday: "Yes",
      tuesday: "No",
      wednesday: "Yes",
      thursday: "No",
      friday: "Yes",
      saturday: "No",
      sunday: "Yes"
    )
    tripRepository.trips = [trip]
    tripRepository.addEventToTrip(trip: trip, dayIndex: 0, event: event)
    guard let updatedTrip = tripRepository.trips.first(where: { $0.id == trip.id }) else {
      XCTFail("Trip not found in the repository.")
      return
    }
    XCTAssertFalse(updatedTrip.days.isEmpty, "Days array should not be empty after adding an event.")
  }
  
  // Test if travelers can be added to a trip
  func testAddTravelers() {
    let trip = Trip(
      id: "123",
      name: "Test Trip",
      startDate: "2024-12-06",
      endDate: "2024-12-10",
      photo: "testPhoto",
      color: "blue",
      days: [],
      travelers: []
    )
    tripRepository.trips = [trip]
    let traveler = User(
      id: "user1",
      name: "John Doe",
      photo: "photoURL1",
      Posts: [],
      Bookmarks: [],
      Trips: [],
      Friends: [],
      Requests: []
    )
    tripRepository.addTravelers(trip: trip, travelers: [traveler])
    guard let updatedTrip = tripRepository.trips.first(where: { $0.id == trip.id }) else {
      XCTFail("Trip not found in the repository.")
      return
    }
    XCTAssertNotNil(updatedTrip.travelers)
  }

  // Test if companions for a trip can be retrieved correctly
  func testGetCompanions() {
    let traveler1 = SimpleUser(id: "user1", name: "John Doe", photo: "photoURL1")
    let traveler2 = SimpleUser(id: "user2", name: "Jane Doe", photo: "photoURL2")
    let trip = Trip(
      id: "123",
      name: "Test Trip",
      startDate: "2024-12-06",
      endDate: "2024-12-10",
      photo: "testPhoto",
      color: "blue",
      days: [],
      travelers: [traveler1, traveler2]
    )
    tripRepository.trips = [trip]
    let companions = tripRepository.getCompanions(tripId: "123")
    XCTAssertEqual(companions.count, 2, "There should be two companions.")
    XCTAssertTrue(
      companions.contains(where: { $0.id == traveler1.id && $0.name == traveler1.name }),
      "Traveler1 should be in the companions list."
    )
    XCTAssertTrue(
      companions.contains(where: { $0.id == traveler2.id && $0.name == traveler2.name }),
      "Traveler2 should be in the companions list."
    )
  }

  // Test if a traveler can be removed from a trip
  func testRemoveTraveler() {
    let traveler = SimpleUser(id: "1", name: "John Doe", photo: "photoURL")
    var trip = Trip(
      id: "456",
      name: "Sample Trip",
      startDate: "2024-12-06",
      endDate: "2024-12-10",
      photo: "tripPhoto",
      color: "red",
      days: [],
      travelers: [traveler]
    )
    tripRepository.trips = [trip]
    tripRepository.removeTraveler(trip: trip, traveler: traveler)
    XCTAssertFalse(
      tripRepository.trips[0].travelers.contains(where: { $0.id == traveler.id }),
      "Traveler should be removed from the trip."
    )
  }

  // Test if the filter function works correctly for trips
  func testFilterTrips() {
    let trip1 = Trip(
      id: "1",
      name: "Trip One",
      startDate: "2024-01-01",
      endDate: "2024-01-10",
      photo: "photo1",
      color: "blue",
      days: [],
      travelers: []
    )
    let trip2 = Trip(
      id: "2",
      name: "Trip Two",
      startDate: "2024-02-01",
      endDate: "2024-02-10",
      photo: "photo2",
      color: "red",
      days: [],
      travelers: []
    )
    tripRepository.trips = [trip1, trip2]
    let filteredTrips = tripRepository.filterTrips(by: ["1"])
    XCTAssertEqual(filteredTrips.count, 1, "Only one trip should be filtered.")
    XCTAssertEqual(filteredTrips[0].id, "1", "Filtered trip ID should match.")
  }

  // Test if the search functionality filters trips correctly
  func testSearchTrips() {
    let trip1 = Trip(
      id: "1",
      name: "Beach Vacation",
      startDate: "2024-01-01",
      endDate: "2024-01-10",
      photo: "photo1",
      color: "blue",
      days: [],
      travelers: []
    )
    let trip2 = Trip(
      id: "2",
      name: "Mountain Adventure",
      startDate: "2024-02-01",
      endDate: "2024-02-10",
      photo: "photo2",
      color: "red",
      days: [],
      travelers: []
    )
    tripRepository.trips = [trip1, trip2]
    tripRepository.search(searchText: "Beach")
    XCTAssertEqual(tripRepository.filteredTrips.count, 1, "One trip should match the search.")
    XCTAssertEqual(tripRepository.filteredTrips[0].name, "Beach Vacation", "Filtered trip name should match.")
  }
  
  // Test if an event can be updated in a trip's day
  func testEditEventInTrip() {
    let expectation = XCTestExpectation(description: "Event should be updated successfully")
    let originalEvent = Event(
      id: "event1",
      startTime: "10:00 AM",
      endTime: "12:00 PM",
      ratings: 4.5,
      latitude: 37.7749,
      longitude: -122.4194,
      image: "original-image-url",
      location: "Original Location",
      title: "Original Title",
      duration: "2 hours",
      address: "123 Main St",
      monday: "Closed",
      tuesday: "9 AM - 5 PM",
      wednesday: "9 AM - 5 PM",
      thursday: "9 AM - 5 PM",
      friday: "9 AM - 5 PM",
      saturday: "10 AM - 4 PM",
      sunday: "Closed"
    )
    let day = Day(id: "day1", date: "2024-12-06", events: [originalEvent])
    let trip = Trip(
      id: "trip1",
      name: "Sample Trip",
      startDate: "2024-12-01",
      endDate: "2024-12-07",
      photo: "trip-photo-url",
      color: "blue",
      days: [day],
      travelers: []
    )
    tripRepository.trips = [trip]
    let updatedEvent = Event(
      id: "event1",
      startTime: "11:00 AM",
      endTime: "1:00 PM",
      ratings: 5.0,
      latitude: 37.7749,
      longitude: -122.4194,
      image: "updated-image-url",
      location: "Updated Location",
      title: "Updated Title",
      duration: "2 hours",
      address: "456 Main St",
      monday: "9 AM - 5 PM",
      tuesday: "9 AM - 5 PM",
      wednesday: "9 AM - 5 PM",
      thursday: "9 AM - 5 PM",
      friday: "9 AM - 5 PM",
      saturday: "10 AM - 4 PM",
      sunday: "10 AM - 4 PM"
    )
    tripRepository.editEventInTrip(
      trip: trip,
      dayIndex: 0,
      eventId: "event1",
      updatedEvent: updatedEvent
    )
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      XCTAssertEqual(self.tripRepository.trips[0].days[0].events[0].title, "Updated Title")
      XCTAssertEqual(self.tripRepository.trips[0].days[0].events[0].startTime, "11:00 AM")
      XCTAssertEqual(self.tripRepository.trips[0].days[0].events[0].location, "Updated Location")
      XCTAssertEqual(self.tripRepository.trips[0].days[0].events[0].image, "updated-image-url")
      expectation.fulfill()
    }
  }
  
  // Test if a trip's photo URL can be updated in Firestore
  func testUpdateTripPhotoURL() {
    let expectation = XCTestExpectation(description: "Wait for photo URL update")
    let trip = Trip(
      id: "trip1",
      name: "Sample Trip",
      startDate: "2024-12-01",
      endDate: "2024-12-07",
      photo: "trip-photo-url",
      color: "blue",
      days: [],
      travelers: []
    )
    tripRepository.trips = [trip]
    let newPhotoURL = "updated-photo-url"
    tripRepository.updateTripPhotoURL(tripId: "123", photoURL: newPhotoURL) { success in
      XCTAssertTrue(success, "Photo URL update should succeed")
      DispatchQueue.main.async {
        XCTAssertEqual(self.tripRepository.trips.first(where: { $0.id == "123" })?.photo, newPhotoURL, "Photo URL should match the updated value")
        expectation.fulfill()
      }
    }
  }
  
  // Test if a trip photo can be uploaded to Firebase Storage
	func testUploadTripPhoto() {
		let expectation = XCTestExpectation(description: "Wait for photo URL update")
		let trip = Trip(
			id: "trip1",
			name: "Sample Trip",
			startDate: "2024-12-01",
			endDate: "2024-12-07",
			photo: "trip-photo-url",
			color: "blue",
			days: [],
			travelers: []
		)
		tripRepository.trips = [trip]
    let newPhotoURL = "updated-photo-url"
		tripRepository.uploadPhotoToStorage(imageData: self.mockImageData, tripId: "123") { success in
			XCTAssertTrue(success != nil, "Photo URL update should succeed")
			DispatchQueue.main.async {
				XCTAssertTrue(self.tripRepository.trips.first(where: { $0.id == "123" })?.photo != nil, "Photo URL should be nonempty")
				expectation.fulfill()
			}
		}
	}
}
