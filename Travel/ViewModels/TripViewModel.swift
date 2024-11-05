//
//  TripViewModel.swift
//  Travel
//
//  Created by Emma Shi on 11/4/24.
//

import Foundation
import Combine

class TripViewModel: ObservableObject, Identifiable {
	private let tripRepository = TripRepository()
	@Published var trip: Trip
	private var cancellables: Set<AnyCancellable> = []
	var id = ""
	
	@Published var days: [Day] = []
	
	init(trip: Trip) {
		self.trip = trip
		$trip
			.compactMap { $0.id }
			.assign(to: \.id, on: self)
			.store(in: &cancellables)
	}
	
}
