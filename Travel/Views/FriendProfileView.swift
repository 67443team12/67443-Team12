//
//  FriendProfileView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

struct FriendProfileView: View {
	// user repo is empty now idk why
	@ObservedObject var userRepository: UserRepository
	@ObservedObject var tripRepository = TripRepository()
	
	let user: User
	let currUser: User
	
	@State private var showAlert = false
	
	var sharedTrips: [Trip] {
		tripRepository.trips.filter { user.Trips.contains($0.id) && currUser.Trips.contains($0.id)}
	}
	
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
								FriendProfileTripCardView(trip: trip, tripRepository: tripRepository)
								// navigation link?
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
					showAlert = true
				}) {
					VStack(spacing: 2) {
						Text("Delete")
							.fontWeight(.semibold)
							.foregroundColor(Color.red)
					}
				}
				.alert(isPresented: $showAlert) {
					Alert(
						title: Text("Delete Friend"),
						message: Text("Are you sure you want to delete this friend?"),
						primaryButton: .destructive(Text("Delete")) {
							userRepository.deleteFriend(currUser: currUser, friend: user)
						},
						secondaryButton: .cancel()
					)
				}
			}
		}
	}
}
