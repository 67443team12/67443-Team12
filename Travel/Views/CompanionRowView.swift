//
//  CompanionRowView.swift
//  Travel
//
//  Created by Emma Shi on 11/3/24.
//

import SwiftUI

struct CompanionRowView: View {
	var person: SimpleUser
	var trip: Trip
	@ObservedObject var tripRepository: TripRepository
	@ObservedObject var userRepository: UserRepository
	@Environment(\.presentationMode) var presentationMode
	@State private var showAlert = false // To trigger alert confirmation
	
	var body: some View {
		HStack(spacing: 20) {
			AsyncImage(url: URL(string: person.photo)) { image in
				image.resizable()
			} placeholder: {
				Circle()
					.fill(Color.gray)
			}
			.frame(width: 50, height: 50)
			.clipShape(Circle())
			Text(person.name)
//				.font(.title3)
//				.fontWeight(.semibold)
			Spacer()
			Button(action: {
				showAlert = true
			}) {
				Text("Remove")
					.padding(12)
					.background(Color("LightPurple"))
					.foregroundColor(Color.black)
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}
			.alert(isPresented: $showAlert) {
				Alert(
					title: Text("Remove Traveler"),
					message: Text("Are you sure you want to remove \(person.name)?"),
					primaryButton: .destructive(Text("Remove")) {
						// remove the traveler
						tripRepository.removeTraveler(trip: trip, traveler: person)
						userRepository.leaveTrip(tripId: trip.id, userId: person.id)
						presentationMode.wrappedValue.dismiss()
					},
					secondaryButton: .cancel()
				)
			}
		}
		.padding(.horizontal, 30)
	}
}
