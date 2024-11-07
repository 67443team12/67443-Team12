//
//  CompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct CompanionsView: View {
	var people: [SimpleUser]
	var trip: Trip
	let tripRepository: TripRepository
	
	var body: some View {
		VStack {
			VStack {
				ForEach(people) { person in
//				Saying that the current user is Alice so not showing her in the list
					if person.id != User.example.id {
						CompanionRowView(person: person, trip: trip, tripRepository: tripRepository)
					}
				}
			}
			.padding(.vertical)
      
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
	CompanionsView(people: [SimpleUser.bob, SimpleUser.clara], trip: Trip.example, tripRepository: TripRepository())
}
