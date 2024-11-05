//
//  TripRepository.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import Combine
import FirebaseFirestore

class TripRepository: ObservableObject {
  // Firestore collection path
  private var path: String = "trips"
  private var store = Firestore.firestore()
  
  // Published variable to store fetched trips
  @Published var trips: [Trip] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }

  func get() {
    // Listen to Firestore changes and fetch trip data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error fetching trips: \(error.localizedDescription)")
          return
        }
      
        // Map the documents to Trip model instances
        self.trips = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Trip.self)
        } ?? []
      }
  }
  
  func addTrip(_ trip: Trip) {
    // Function to add a new trip to Firestore
    do {
			let newTrip = trip
      _ = try store.collection(path).document(newTrip.id).setData(from: newTrip)
    } catch {
      print("Error adding trip: \(error.localizedDescription)")
    }
  }
	
	func updateTravelers(trip: Trip, travelers: [SimpleUser]) {
		guard !trip.id.isEmpty else { return }  // Check that the trip id is valid

		let travelerData = travelers.map { traveler in
			[
				"userId": traveler.id,
				"name": traveler.name,
				"photo": traveler.photo
			]
		}
		
		store.collection(path).document(trip.id).updateData([
			"travelers": travelerData  // Storing travelers as a list of dictionaries
		]) { error in
			if let error = error {
				print("Error updating travelers: \(error)")
			} else {
				print("Travelers list successfully updated.")
			}
		}
	}
}

