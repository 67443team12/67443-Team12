//
//  LocationRepository.swift
//  kailan-team12
//
//  Created by Kailan Mao on 11/4/24.
//

import Combine
// import Firebase modules here
import FirebaseCore
import FirebaseFirestore

class LocationRepository: ObservableObject {
  // Firestore reference
  private var db = Firestore.firestore()
  
  // Published array to store fetched locations
  @Published var locations: [Location] = []
  @Published var filteredLocations: [Location] = []
  @Published var searchText: String = ""
  
  // Firestore listener to keep track of real-time updates
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    // Ensure Firebase is configured
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }
    
    // Call the get function to fetch data when initialized
    get()
  }
  
  func get() {
    // Fetch data from the Firestore "locations" collection
    db.collection("locations").addSnapshotListener { (querySnapshot, error) in
      // Error handling
      if let error = error {
        print("Error fetching locations: \(error)")
        return
      }
      
      // Clear current locations
      self.locations.removeAll()
      
      // Parse the fetched documents into the locations array
      if let querySnapshot = querySnapshot {
        self.locations = querySnapshot.documents.compactMap { document in
          try? document.data(as: Location.self)
        }
      }
    }
  }
  
  // Function to filter locations based on a search string
  func search(searchText: String) {
    if searchText == "" {
      return
    }
    self.filteredLocations = self.locations.filter { location in
      return location.name.lowercased().contains(searchText.lowercased())
    }
  }
}
