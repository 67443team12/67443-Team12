//
//  CompanionViewModel.swift
//  Travel
//
//  Created by Emma Shi on 11/5/24.
//

import Foundation
import Combine

class CompanionViewModel: ObservableObject {
	@Published var travelers: [SimpleUser] = []
	private var tripViewModel: TripViewModel
	private var cancellables: Set<AnyCancellable> = []
	private let tripRepository = TripRepository()

	init(tripViewModel: TripViewModel) {
		self.tripViewModel = tripViewModel
		self.travelers = tripViewModel.trip.travelers // Initialize travelers from the trip
	}

	func removeTraveler(_ traveler: SimpleUser) {
		// Remove the traveler from Firestore directly using the repository
		if let index = travelers.firstIndex(where: { $0.id == traveler.id }) {
			travelers.remove(at: index) // Update local list
			// Call the repository method to update Firestore
			tripRepository.updateTravelers(trip: tripViewModel.trip, travelers: travelers)
		}
	}
}
