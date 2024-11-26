//
//  MockUser.swift
//  Travel
//
//  Created by Emma Shi on 11/7/24.
//

import Foundation
import SwiftUI

class MockUser: ObservableObject {
	@Published var user: User
	
	init(user: User) {
		self.user = user
	}
	
//	func addTrip(tripID: String) {
//		if !user.Trips.contains(tripID) {
//			user.Trips.append(tripID)
//		}
//	}
//	
//	func removeTrip(tripID: String) {
//		user.Trips.removeAll { $0 == tripID }
//	}
}
