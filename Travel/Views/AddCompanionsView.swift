//
//  AddCompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/7/24.
//

import SwiftUI

struct AddCompanionsView: View {
	var trip: Trip
	let tripRepository: TripRepository
	var onCompanionsAdded: ([SimpleUser]) -> Void
//	var availableFriends: [SimpleUser] {
//		aliceVM.user.Friends.filter { friend in
//			!trip.travelers.contains { traveler in
//				traveler.id == friend.id
//			}
//		}
//	}
	
	@EnvironmentObject var aliceVM: MockUser
	@Environment(\.presentationMode) var presentationMode
	@State private var selectedFriends: [SimpleUser] = []
	
	var body: some View {
		VStack {
//			List(availableFriends) { friend in
//				HStack(spacing: 20) {
//					Circle()
//						.fill(.blue)
//						.frame(width: 44, height: 44)
//					Text(friend.name)
//					Spacer()
//					if selectedFriends.contains(where: { $0.id == friend.id }) {
//						Image(systemName: "checkmark.circle.fill")
//							.foregroundColor(.green)
//					} else {
//						Image(systemName: "circle")
//							.foregroundColor(.gray)
//					}
//				}
//				.contentShape(Rectangle())  // Make the whole row tappable
//				.onTapGesture {
//					toggleSelection(friend)
//				}
//			}
			// Save button appear only after choosing someone
			if !selectedFriends.isEmpty {
				Button(action: {
					saveCompanions()
				}) {
					ZStack {
						Rectangle()
							.fill(Color("AccentColor"))
							.frame(height: 70)
							.cornerRadius(10)
						Text("Add Companions")
							.foregroundColor(.white)
							.fontWeight(.bold)
					}
					.padding(.horizontal)
				}
			}
		}
		.navigationTitle("Add Companions")
		.navigationBarTitleDisplayMode(.inline)
	}
	
	private func toggleSelection(_ friend: SimpleUser) {
		if let index = selectedFriends.firstIndex(where: { $0.id == friend.id }) {
			selectedFriends.remove(at: index)
		} else {
			selectedFriends.append(friend)
		}
	}
	
	private func saveCompanions() {
		// Add selected friends to the trip
		tripRepository.addTravelers(trip: trip, travelers: selectedFriends)
		
		// Call the completion handler to update companions in CompanionsView
		var updatedCompanions = trip.travelers
		updatedCompanions.append(contentsOf: selectedFriends)
		onCompanionsAdded(updatedCompanions)
		
		// Dismiss this view to go back to CompanionsView
		presentationMode.wrappedValue.dismiss()
	}
}

//#Preview {
//	AddCompanionsView(trip: Trip.example, tripRepository: TripRepository(), onCompanionsAdded: { _ in }).environmentObject(MockUser(user: User.example))
//}
