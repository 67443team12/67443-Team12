//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripDetailsView: View {
  var trip: Trip
  @State private var days: [String] = []
  @State private var searchText: String = ""
	@State private var currentIndex = 0
	@State private var selectedIndex = 0

	var body: some View {
		VStack {
			// MARK: Name and companions row
			HStack() {
				Text(trip.tripName)
					.font(.largeTitle)
					.fontWeight(.bold)
					.frame(maxWidth: .infinity, alignment: .center)
			}
			// Use overlay for the companion link to ensure the trip name is at the center
			.overlay(
				NavigationLink(destination: CompanionsView(people: trip.travelers))
				{
					Image(systemName: "person.3")
						.font(.title)
							.fontWeight(.bold)
							.padding(.trailing)
					}
				.frame(maxWidth: .infinity, alignment: .trailing)
			)
			
			// MARK: Day View
			if !trip.days.isEmpty {
				HStack {
					Button(action: {
						if currentIndex > 0 {
							currentIndex -= 1
						}
					}) {
						Image(systemName: "arrow.backward")
					}
					.disabled(currentIndex == 0)
					
					Spacer()
					
					Text("Day \(currentIndex + 1): \(trip.days[currentIndex].date)")
						.font(.headline)
						.padding()
						.background(Color(.systemGray5))
						.cornerRadius(10)
					
					Spacer()
					
					Button(action: {
						if currentIndex < trip.days.count - 1 {
							currentIndex += 1
						}
					}) {
						Image(systemName: "arrow.forward")
					}
					.disabled(currentIndex == trip.days.count - 1)
				}
				.padding(.horizontal)
				.padding(.bottom, 10)
				
				// One day view for each day object
				DayView(day: trip.days[currentIndex], searchText: $searchText)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.transition(.slide)
			} else {
				Text("Loading days...")
					.font(.subheadline)
					.foregroundColor(.gray)
					.padding()
			}
		}
		// this will make the tab bar hidden forever even when return to my trips page
//		.toolbar(.hidden, for: .tabBar)
	}
}

struct TripDetailsView_Previews: PreviewProvider {
  static var previews: some View {
		TripDetailsView(trip: Trip.example)
  }
}
