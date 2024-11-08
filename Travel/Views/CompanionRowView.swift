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
	let tripRepository: TripRepository
	@Environment(\.presentationMode) var presentationMode
	@State private var showAlert = false // To trigger alert confirmation
	
	var body: some View {
		HStack(spacing: 20) {
			Circle()
        .fill(.blue)
				.frame(width: 50, height: 50)
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
						presentationMode.wrappedValue.dismiss()
					},
					secondaryButton: .cancel()
				)
			}
		}
		.padding(.horizontal, 30)
	}
}

#Preview {
	CompanionRowView(person: SimpleUser.bob, trip: Trip.example, tripRepository: TripRepository())
}
