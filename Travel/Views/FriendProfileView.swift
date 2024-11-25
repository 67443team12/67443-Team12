//
//  FriendProfileView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

struct FriendProfileView: View {
	// user repo is empty now idk why
	@ObservedObject var userRepository = UserRepository()
	@ObservedObject var tripRepository = TripRepository()
	// should have a function to fetch a user from the user repository using user id
	//	var userId: String
	let user = User.bob
	// this needs to be revised to filter on the current user and selected user's common trip
	var sharedTrips: [Trip] {
		tripRepository.filterTrips(by: user.Trips)
		// Filter trips based on user's trip IDs
	}
	
	@EnvironmentObject var aliceVM: MockUser
	
	@State private var isSharedTripsExpanded: Bool = true
	
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					AsyncImage(url: URL(string: user.photo)) { image in
						image.resizable()
					} placeholder: {
						Color.gray
					}
					.frame(width: 100, height: 100)
					.clipShape(Circle())
					.padding(.leading, 20)
					VStack(alignment: .leading) {
						Text(user.name)
							.font(.largeTitle)
							.fontWeight(.semibold)
						Text("ID: \(user.id)")
							.fontWeight(.semibold)
					}
					.padding(.leading, 20)
					Spacer()
				}
				List {
					Section(header: HStack {
										Text("Shared Trips")
											.font(.headline)
										Spacer()
										Button(action: {
											withAnimation {
												isSharedTripsExpanded.toggle()
											}
										}) {
											Image(systemName: isSharedTripsExpanded ? "chevron.up" : "chevron.down")
												.font(.caption)
												.foregroundColor(.gray)
										}
					}) {
						if isSharedTripsExpanded {
							ForEach(sharedTrips, id: \.id) { trip in
								Text(trip.name)
								// Replace with a custom card view if needed
							}
						}
					}
					// Do we really need other trips?
					Section { } header: {
						Text("Other Trips")
					}
				}
				.listStyle(PlainListStyle())
			}
		}
		.padding(.top)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					// delete a friend
				}) {
					VStack(spacing: 2) {
						Text("Delete")
							.fontWeight(.semibold)
							.foregroundColor(Color.red)
					}
				}
			}
		}
	}
}

#Preview {
	FriendProfileView()
		.environmentObject(MockUser(user: User.example))
}
