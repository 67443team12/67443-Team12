//
//  TripRepoTests.swift
//  Travel
//
//  Created by k mao on 12/6/24.
//

import XCTest
import Combine
@testable import Travel

class TripRepositoryTests: XCTestCase {
  var tripRepository: TripRepository!
  var cancellables: Set<AnyCancellable>!

  override func setUp() {
    super.setUp()
    tripRepository = TripRepository()
    tripRepository.trips = [] // Clear trips array before each test
    cancellables = [] // Initialize the cancellables set
  }

  override func tearDown() {
    tripRepository = nil
    cancellables = nil
    super.tearDown()
  }

  func testAddTrip() {
    // Create a new trip
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

    // Use an expectation to wait for Firestore updates
    let expectation = self.expectation(description: "Waiting for Firestore update")

    // Observe the published trips array for changes
    tripRepository.$trips
      .dropFirst() // Skip the initial value
      .sink { trips in
        if let addedTrip = trips.first(where: { $0.id == newTrip.id }) {
          // Assert that the trip's properties match
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

    // Call addTrip to add the new trip
    tripRepository.addTrip(newTrip)

    // Wait for expectations
    waitForExpectations(timeout: 5.0, handler: nil)
  }

  func testAddEventToTrip() {
    // Create a trip with one day containing no events
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

    // Create an event to add
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

    // Add the trip to the repository
    tripRepository.trips = [trip]

    // Call the function to add the event to the trip
    tripRepository.addEventToTrip(trip: trip, dayIndex: 0, event: event)

    // Ensure the trip exists in the repository
    guard let updatedTrip = tripRepository.trips.first(where: { $0.id == trip.id }) else {
      XCTFail("Trip not found in the repository.")
      return
    }

    // Assert that the `days` array is not empty
    XCTAssertFalse(updatedTrip.days.isEmpty, "Days array should not be empty after adding an event.")
  }
  
  func testAddTravelers() {
    // Create a trip with no travelers
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
    
    // Add the trip to the repository
    tripRepository.trips = [trip]
    
    // Travelers to be added
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
    
    // Add travelers to the trip
    tripRepository.addTravelers(trip: trip, travelers: [traveler])
    
    // Verify that the travelers are added to the trip
    guard let updatedTrip = tripRepository.trips.first(where: { $0.id == trip.id }) else {
      XCTFail("Trip not found in the repository.")
      return
    }
    
    XCTAssertNotNil(updatedTrip.travelers)
  }

  func testGetCompanions() {
    // Create a trip with travelers
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
    
    // Add the trip to the repository
    tripRepository.trips = [trip]
    
    // Get companions for the trip
    let companions = tripRepository.getCompanions(tripId: "123")
    
    // Assert that the companions list is correct
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
}
