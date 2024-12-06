
import XCTest
@testable import Travel

class TripRepositoryTests: XCTestCase {
  var tripRepository: TripRepository!
  
  override func setUp() {
      super.setUp()
      tripRepository = TripRepository()
      tripRepository.trips = []
  }
  
  func testFetchTrips() {
      // Simulate Firebase data
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
      tripRepository.trips = [mockTrip]
      
      XCTAssertEqual(tripRepository.trips.count, 1)
      XCTAssertEqual(tripRepository.trips[0].name, "Test trip")
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
      
    // Create an expectation to wait for 1 second
    let expectation = self.expectation(description: "Waiting for 1 second before assertion")

    // Call addTrip to add the new trip
    tripRepository.addTrip(newTrip)

    // Dispatching to a background queue to simulate waiting asynchronously
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      // Fulfill the expectation after 1 second
      expectation.fulfill()
    }
    
    // Wait for the expectation to be fulfilled
    waitForExpectations(timeout: 2, handler: nil)
      
      // Assert that the trip was added to the trips array
      XCTAssertEqual(tripRepository.trips.count, 1, "There should be 1 trip in the repository")
      
      // Assert that the added trip's properties are correct
      XCTAssertEqual(tripRepository.trips[0].id, "456", "The trip ID should match")
      XCTAssertEqual(tripRepository.trips[0].name, "New Trip", "The trip name should match")
      XCTAssertEqual(tripRepository.trips[0].startDate, "2024-12-15", "The start date should match")
      XCTAssertEqual(tripRepository.trips[0].endDate, "2024-12-20", "The end date should match")
      XCTAssertEqual(tripRepository.trips[0].photo, "newPhoto", "The photo should match")
      XCTAssertEqual(tripRepository.trips[0].color, "green", "The color should match")
    }
  
  
  
}
