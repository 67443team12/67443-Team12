//
//  CompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct CompanionsView: View {
//	var people: [SimpleUser]
	var trip: Trip
	let tripRepository: TripRepository
	
	@State private var showAlert = false
	@State private var companions: [SimpleUser]
	
	@EnvironmentObject var aliceVM: MockUser
	@Environment(\.presentationMode) var presentationMode
	
	init(trip: Trip, tripRepository: TripRepository) {
		self.trip = trip
		self.tripRepository = tripRepository
		_companions = State(initialValue: trip.travelers)
	}
	
	var body: some View {
		VStack {
			VStack {
				ForEach(companions) { person in
					//	Pretending that the current user is Alice so not showing her in the list
					if person.id != User.example.id {
						CompanionRowView(person: person, trip: trip, tripRepository: tripRepository)
					}
				}
			}
			.padding(.vertical)
			
			NavigationLink(destination: AddCompanionsView(trip: trip, tripRepository: tripRepository, onCompanionsAdded: refreshCompanions).environmentObject(aliceVM)) {
				ZStack {
					Rectangle()
						.fill(Color("LightPurple"))
						.frame(height: 70)
					HStack() {
						Text("Invite More Friends")
							.padding(.leading, 30)
							.fontWeight(.semibold)
						Spacer()
						Image(systemName: "arrow.right")
							.fontWeight(.semibold)
							.padding(.trailing, 30)
					}
					.foregroundStyle(.black)
				}
			}
			
			Spacer()
			
			Button(action: {
				showAlert = true
			}) {
				ZStack {
					Rectangle()
						.fill(Color("LightPurple"))
						.frame(height: 70)
					Text("Leave Trip")
						.foregroundColor(.red)
						.fontWeight(.bold)
				}
			}.alert(isPresented: $showAlert) {
				Alert(
					title: Text("Leave Trip"),
					message: Text("Are you sure you want to leave this trip?"),
					primaryButton: .destructive(Text("Leave")) {
						leaveTrip()
					},
					secondaryButton: .cancel()
				)
			}
		}
		.navigationTitle("Companions")
		.navigationBarTitleDisplayMode(.inline)
	}
	
	func refreshCompanions(newCompanions: [SimpleUser]) {
		// Update the companions list after friends are added
		companions = newCompanions
	}
	
	func leaveTrip() {
		// Remove the trip from Alice's trips in the ViewModel
		aliceVM.removeTrip(tripID: trip.id)
		// Remove Alice from the trip's travelers in Firestore
		tripRepository.removeTraveler(trip: trip, traveler: SimpleUser.alice)
		
		presentationMode.wrappedValue.dismiss()
	}
	
}

#Preview {
	CompanionsView(trip: Trip.example, tripRepository: TripRepository())
		.environmentObject(MockUser(user: User.example))
}
