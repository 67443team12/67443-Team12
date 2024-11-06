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
                  if let events = day["events"] as? [[String: Any]] {
                          print("Events array:", events)
                          
                    let eventData = event.toDictionary()
                    // Access the specific day and append the new event to its events array
                    var events = days[dayIndex]["events"] as? [[String: Any]] ?? []
                    events.append(eventData)
                    days[dayIndex]["events"] = events
                    
                    tripRef.updateData(["days": days]) { error in
                                if let error = error {
                                    print("Error updating document: \(error.localizedDescription)")
                                } else {
                                    print("Event successfully added to Firestore.")
                                  self.trips.insert(trip, at: 0)
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
}

