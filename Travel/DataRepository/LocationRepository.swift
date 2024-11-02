//
//  LocationRepository.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import Combine
import FirebaseFirestore

class LocationRepository: ObservableObject {
	
	private var path: String = "locations"
	private var store = Firestore.firestore()
	
	@Published var locations: [Location] = []
	private var cancellables: Set<AnyCancellable> = []
	
	init() {
		self.get()
	}
	
	func get() {
		// Listen to Firestore changes and fetch trip data
		store.collection(path)
			.addSnapshotListener { querySnapshot, error in
				if let error = error {
					print("Error fetching locations: \(error.localizedDescription)")
					return
				}
			
				// Map the documents to Trip model instances
				self.locations = querySnapshot?.documents.compactMap { document in
					try? document.data(as: Location.self)
				} ?? []
			}
	}
}
