//
//  LocationRepository.swift
//  Travel
//
//  Created by Kailan Mao on 11/4/24.
//

import Combine
import FirebaseCore
import FirebaseFirestore

class LocationRepository: ObservableObject {
  // Properties
  private var db = Firestore.firestore()
  @Published var locations: [Location] = []
  @Published var filteredLocations: [Location] = []
  @Published var searchText: String = ""
  private var cancellables = Set<AnyCancellable>()
  
  // Initializer
  init() {
    if FirebaseApp.app() == nil {
      FirebaseApp.configure()
    }
    get()
  }
  
  // Fetches data from the Firestore "locations" collection and listens for real-time updates
  func get() {
    db.collection("locations").addSnapshotListener { (querySnapshot, error) in
      if let error = error {
        print("Error fetching locations: \(error)")
        return
      }
      self.locations.removeAll()
      if let querySnapshot = querySnapshot {
        self.locations = querySnapshot.documents.compactMap { document in
          try? document.data(as: Location.self)
        }
      }
    }
  }
  
  // Filters the locations array based on the provided search text
  func search(searchText: String) {
    if searchText == "" {
      return
    }
    self.filteredLocations = self.locations.filter { location in
      return location.name.lowercased().contains(searchText.lowercased())
    }
  }
}
