//
//  TripRepository.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import Combine
import FirebaseFirestore

class TripRepository: ObservableObject {
  private var path: String = "trips"
  private var store = Firestore.firestore()
  @Published var trips: [Trip] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }
  
  func get() {
    store.collection(path).addSnapshotListener { querySnapshot, error in
      if let error = error {
        print("Error fetching trips: \(error.localizedDescription)")
        return
      }
      
      self.trips = querySnapshot?.documents.compactMap { document in
        try? document.data(as: Trip.self)
      } ?? []
    }
  }
  
  func addTrip(_ trip: Trip) {
    do {
      try store.collection(path).document(trip.id).setData(from: trip)
    } catch {
      print("Error adding trip: \(error.localizedDescription)")
    }
  }
  
  // Updated function to update a specific event within a specific trip and day
  func updateEvent(tripId: String, dayId: String, updatedEvent: Event) {
    let tripRef = store.collection(path).document(tripId)
    
    tripRef.getDocument { document, error in
      if let error = error {
        print("Error retrieving trip document: \(error.localizedDescription)")
        return
      }
      
      guard let document = document, var tripData = document.data(),
            var days = tripData["days"] as? [[String: Any]] else {
        print("No trip data or days array found.")
        return
      }
      
      // Find the specific day by matching `dayId`
      if let dayIndex = days.firstIndex(where: { $0["id"] as? String == dayId }),
         var events = days[dayIndex]["events"] as? [[String: Any]],
         let eventIndex = events.firstIndex(where: { $0["id"] as? String == updatedEvent.id.uuidString }) {
        
        // Update the event within the array
        events[eventIndex] = updatedEvent.toDictionary() // Convert Event to dictionary format
        days[dayIndex]["events"] = events
        tripData["days"] = days
        
        // Write the updated days array back to Firestore
        tripRef.setData(tripData) { error in
          if let error = error {
            print("Error updating event in Firestore: \(error.localizedDescription)")
          } else {
            print("Event successfully updated in Firestore.")
            self.get()
          }
        }
      } else {
        print("No matching day or event found.")
      }
    }
  }
  
  func deleteEvent(tripId: String, dayId: String, eventId: UUID) {
    let tripRef = store.collection(path).document(tripId)
    
    tripRef.getDocument { document, error in
      if let error = error {
        print("Error retrieving trip document: \(error.localizedDescription)")
        return
      }
      
      guard let document = document, var tripData = document.data(),
            var days = tripData["days"] as? [[String: Any]] else {
        print("No trip data or days array found.")
        return
      }
      
      // Locate the day and event by id
      if let dayIndex = days.firstIndex(where: { $0["id"] as? String == dayId }),
         var events = days[dayIndex]["events"] as? [[String: Any]],
         let eventIndex = events.firstIndex(where: { $0["id"] as? String == eventId.uuidString }) {
        
        // Remove the event from the array
        events.remove(at: eventIndex)
        days[dayIndex]["events"] = events
        tripData["days"] = days
        
        // Update Firestore
        tripRef.setData(tripData) { error in
          if let error = error {
            print("Error deleting event in Firestore: \(error.localizedDescription)")
          } else {
            print("Event successfully deleted from Firestore.")
            self.get() // Refresh local data after deletion
          }
        }
      } else {
        print("No matching day or event found.")
      }
    }
  }
}
