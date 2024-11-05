//
//  TripListViewModel.swift
//  Travel
//
//  Created by Emma Shi on 11/4/24.
//

import Foundation
import Combine

class TripListViewModel: ObservableObject {
	@Published var tripViewModels: [TripViewModel] = []
	private var cancellables: Set<AnyCancellable> = []
	
	@Published var tripRepository = TripRepository()
	@Published var trips: [Trip] = []
	
	init() {
		tripRepository.$trips.map { trips in
			trips.map(TripViewModel.init)
		}
		.assign(to: \.tripViewModels, on: self)
		.store(in: &cancellables)
	}
	
	func add(_ trip: Trip) {
		tripRepository.addTrip(trip)
	}
}
