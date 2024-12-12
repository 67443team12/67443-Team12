//
//  TripRepository.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import Combine
import FirebaseFirestore
import FirebaseStorage

class TripRepository: ObservableObject {
  // Properties
  private var path: String = "trips"
  private var store = Firestore.firestore()
  private var storage = Storage.storage()
  @Published var trips: [Trip] = []
  @Published var filteredTrips: [Trip] = []
  private var cancellables: Set<AnyCancellable> = []
  
  // Initializer
  init() {
    self.get()
  }
  
  // Fetches trip data from Firestore and listens for real-time updates
  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error fetching trips: \(error.localizedDescription)")
          return
        }
        self.trips = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Trip.self)
        } ?? []
      }
  }
  
  // Adds a new trip to Firestore
  func addTrip(_ trip: Trip) {
    do {
      try store.collection(path).document(trip.id).setData(from: trip)
    } catch {
      print("Error adding trip: \(error.localizedDescription)")
    }
  }
  
  // Adds an event to a specific day in a trip in Firestore
  func addEventToTrip(trip: Trip, dayIndex: Int, event: Event) {
    let tripRef = store.collection("trips").document(trip.id)
    tripRef.getDocument { document, error in
      if let document = document, document.exists {
        if var days = document.data()?["days"] as? [[String: Any]] {
          print("Days array:", days)
          let day = days[dayIndex]
          if var events = day["events"] as? [[String: Any]] {
            print("Events array:", events)
            let eventData = event.toDictionary()
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
  
  // Edits an existing event in a trip
  func editEventInTrip(trip: Trip, dayIndex: Int, eventId: String, updatedEvent: Event) {
    let tripRef = store.collection("trips").document(trip.id)
    tripRef.getDocument { document, error in
      if let document = document, document.exists {
        if var days = document.data()?["days"] as? [[String: Any]] {
          if var events = days[dayIndex]["events"] as? [[String: Any]] {
            if let eventIndex = events.firstIndex(where: { $0["id"] as? String == eventId }) {
              let updatedEventData = updatedEvent.toDictionary()
              events[eventIndex] = updatedEventData
              days[dayIndex]["events"] = events
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
  
  // Adds travelers to a trip and updates Firestore
  func addTravelers(trip: Trip, travelers: [User]) {
    let tripRef = store.collection(path).document(trip.id)
    var simpleTravelers: [SimpleUser] = travelers.map { user in
      SimpleUser(id: user.id, name: user.name, photo: user.photo)
    }
    var updatedTravelers = trip.travelers
    for traveler in simpleTravelers {
      if !updatedTravelers.contains(where: { $0.id == traveler.id }) {
        updatedTravelers.append(traveler)
      }
    }
    tripRef.updateData(["travelers": updatedTravelers.map { $0.toDictionary() }]) { error in
      if let error = error {
        print("Error adding travelers to Firestore: \(error.localizedDescription)")
      } else {
        print("Travelers added successfully to Firestore.")
      }
    }
    self.get()
  }
  
  // Gets companions (travelers) of a trip
  func getCompanions(tripId: String) -> [SimpleUser] {
    if let trip = trips.first(where: { $0.id == tripId }) {
     return trip.travelers
    }
    return []
  }
  
  // Removes a traveler from a trip
  func removeTraveler(trip: Trip, traveler: SimpleUser) {
    guard let tripIndex = trips.firstIndex(where: { $0.id == trip.id }) else {
      print("Trip not found")
      return
    }
    var updatedTrip = trips[tripIndex]
    updatedTrip.travelers.removeAll { $0.id == traveler.id }
    trips[tripIndex] = updatedTrip
    let tripRef = store.collection("trips").document(trip.id)
    let updatedTravelers = updatedTrip.travelers.map { [
      "userId": $0.id,
      "name": $0.name,
      "photo": $0.photo
    ]}
    tripRef.updateData(["travelers": updatedTravelers]) { error in
      if let error = error {
        print("Error removing traveler: \(error.localizedDescription)")
      } else {
        print("Traveler successfully removed")
      }
    }
  }
  
  // Uploads a trip photo to Firebase Storage and updates Firestore
  func uploadPhotoToStorage(imageData: Data, tripId: String, completion: @escaping (String?) -> Void) {
    let storageRef = storage.reference().child("trip_photos/\(UUID().uuidString).jpg")
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    storageRef.putData(imageData, metadata: metadata) { metadata, error in
      if let error = error {
        print("Error uploading photo: \(error.localizedDescription)")
        completion(nil)
        return
      }
      storageRef.downloadURL { url, error in
        if let error = error {
          print("Error fetching photo URL: \(error.localizedDescription)")
          completion(nil)
          return
        }
        if let downloadURL = url {
          self.updateTripPhotoURL(tripId: tripId, photoURL: downloadURL.absoluteString) { success in
            if success {
              completion(downloadURL.absoluteString)
            } else {
              completion(nil)
            }
          }
        }
      }
    }
  }
  
  // Updates the photo URL of a trip in Firestore
  func updateTripPhotoURL(tripId: String, photoURL: String, completion: @escaping (Bool) -> Void) {
    let tripRef = store.collection(path).document(tripId)
    tripRef.updateData(["photo": photoURL]) { error in
      if let error = error {
        print("Error updating photo URL: \(error.localizedDescription)")
        completion(false)
        return
      }
      print("Photo URL updated successfully in Firestore.")
      completion(true)
    }
  }
  
  // Filters trips by a given list of IDs
  func filterTrips(by tripIds: [String]) -> [Trip] {
    return trips.filter { trip in
      tripIds.contains(trip.id)
    }
  }
  
  // Searches trips by name
  func search(searchText: String) {
    if searchText == "" {
      return
    }
    self.filteredTrips = self.trips.filter { trip in
      return trip.name.lowercased().contains(searchText.lowercased())
    }
  }
}
