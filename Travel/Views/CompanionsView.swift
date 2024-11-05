//
//  CompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct CompanionsView: View {
	@ObservedObject var companionViewModel: CompanionViewModel
	@Environment(\.presentationMode) var presentationMode
	@State private var showAlert = false
	@State private var travelerToRemove: SimpleUser? // Traveler to remove
	
	init(tripViewModel: TripViewModel) {
		self.companionViewModel = CompanionViewModel(tripViewModel: tripViewModel)
	}
	
	var body: some View {
		VStack {
			VStack {
				ForEach(companionViewModel.travelers) { person in
					if person.id != User.example.id {
						HStack(spacing: 20) {
							Circle()
								.fill(.blue)
								.frame(width: 50, height: 50)
							Text(person.name)
								.font(.title3)
								.fontWeight(.semibold)
							Spacer()
							Button(action: {
								travelerToRemove = person
								showAlert = true
							}) {
								Text("Remove")
									.padding(12)
									.background(Color("LightPurple"))
									.foregroundColor(Color.black)
									.clipShape(RoundedRectangle(cornerRadius: 10))
							}
						}
						.padding(.horizontal, 30)
					}
				}
			}
			.padding(.vertical)
			.alert(isPresented: $showAlert) {
				Alert(
					title: Text("Remove Companion"),
					message: Text("Are you sure you want to remove \(travelerToRemove?.name ?? "") from this trip?"),
					primaryButton: .destructive(Text("Remove")) {
						if let traveler = travelerToRemove {
							companionViewModel.removeTraveler(traveler)
							presentationMode.wrappedValue.dismiss()
						}
					},
					secondaryButton: .cancel())
			}
			
			NavigationLink(destination: SelectFriendsView()) {
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
		}
		.navigationTitle("Companions")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	CompanionsView(tripViewModel: TripViewModel(trip: Trip.example))
}
