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
      try store.collection(path).document(trip.id).setData(from: trip)
    } catch {
      print("Error adding trip: \(error.localizedDescription)")
    }
  }
  
  func addEventToTrip(trip: Trip, dayIndex: Int, event: Event) {
    let tripRef = store.collection("trips").document(trip.id)
    tripRef.getDocument { document, error in
      if let document = document, document.exists {
        // Access the 'days' array directly from the document data
        if var days = document.data()?["days"] as? [[String: Any]] {
          print("Days array:", days)
          // You can now manipulate or inspect the 'days' array as needed
          let day = days[dayIndex]
          // access events
          if var events = day["events"] as? [[String: Any]] {
            print("Events array:", events)
            
            let eventData = event.toDictionary()
            // Access the specific day and append the new event to its events array
            events.append(eventData)
            days[dayIndex]["events"] = events
            
            tripRef.updateData(["days": days]) { error in
              if let error = error {
                print("Error updating document: \(error.localizedDescription)")
              } else {
                print("Event successfully added to Firestore.")
              }
            }
          } else {
            print("No 'events' array found for this day.")
          }
        } else {
          print("The 'days' array does not exist in this trip document.")
        }
      } else {
        print("Error accessing trip document or document does not exist: \(error?.localizedDescription ?? "Unknown error")")
      }
    }
  }
  
  func editEventInTrip(trip: Trip, dayIndex: Int, eventId: String, updatedEvent: Event) {
    let tripRef = store.collection("trips").document(trip.id)
    
    tripRef.getDocument { document, error in
      if let document = document, document.exists {
        // Access the 'days' array from the document data
        if var days = document.data()?["days"] as? [[String: Any]] {
          if var events = days[dayIndex]["events"] as? [[String: Any]] {
            // Find the index of the event to be edited
            if let eventIndex = events.firstIndex(where: { $0["id"] as? String == eventId }) {
              // Convert the updated event to a dictionary
              let updatedEventData = updatedEvent.toDictionary()
              
              // Update the event at the specific index
              events[eventIndex] = updatedEventData
              days[dayIndex]["events"] = events
              
              // Update Firestore with the modified 'days' array
              tripRef.updateData(["days": days]) { error in
                if let error = error {
                  print("Error updating event in Firestore: \(error.localizedDescription)")
                } else {
                  print("Event successfully updated in Firestore.")
                }
              }
            } else {
              print("Event with ID \(eventId) not found in the specified day.")
            }
          } else {
            print("No 'events' array found for this day.")
          }
        } else {
          print("The 'days' array does not exist in this trip document.")
        }
      } else {
        print("Error accessing trip document or document does not exist: \(error?.localizedDescription ?? "Unknown error")")
      }
    }
  }
	
	func addTravelers(trip: Trip, travelers: [SimpleUser]) {
		let tripRef = store.collection(path).document(trip.id)
		
		// Combine existing travelers with the new travelers
		var updatedTravelers = trip.travelers
		for traveler in travelers {
			if !updatedTravelers.contains(where: { $0.id == traveler.id }) {
				updatedTravelers.append(traveler)
			}
		}
		
		// Update Firestore with the new list of travelers
		tripRef.updateData(["travelers": updatedTravelers.map { $0.toDictionary() }]) { error in
			if let error = error {
				print("Error adding travelers to Firestore: \(error.localizedDescription)")
			} else {
				print("Travelers added successfully to Firestore.")
			}
		}
	}
	
	func removeTraveler(trip: Trip, traveler: SimpleUser) {
		// Create a reference to the specific trip document in Firestore
		let tripRef = store.collection(path).document(trip.id)

		// Remove the traveler from the local list
		var updatedTravelers = trip.travelers
		if let index = updatedTravelers.firstIndex(where: { $0.id == traveler.id }) {
			updatedTravelers.remove(at: index)

			// Update Firestore by setting the updated list of travelers
			tripRef.updateData(["travelers": updatedTravelers.map { $0.toDictionary() }]) { error in
				if let error = error {
					print("Error updating travelers in Firestore: \(error.localizedDescription)")
				} else {
					print("Travelers updated successfully in Firestore.")
				}
			}
		} else {
			print("Traveler not found in the trip.")
		}
	}
	
}
