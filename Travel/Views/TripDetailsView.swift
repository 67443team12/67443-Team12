//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripDetailsView: View {
  var trip: Trip
  @State private var selectedIndex = 0
  @State private var searchText: String = ""

	var body: some View {
			// 1. name + companion row
			// 2. date change row + main content (scroll)
		VStack {
			// Name and companions row
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
			// Switch date row
      if !trip.days.isEmpty {
				HStack {
					Button(action: {
						if selectedIndex > 0 {
							selectedIndex -= 1
						}
					}) {
						Image(systemName: "arrow.backward")
					}
					.disabled(selectedIndex == 0)
					
					Spacer()
					
          Text("Day \(selectedIndex + 1): \(trip.days[selectedIndex].date)")
						.font(.headline)
						.padding()
						.background(Color(.systemGray5))
						.cornerRadius(10)
					
					Spacer()
					
					Button(action: {
            if selectedIndex < trip.days.count - 1 {
							selectedIndex += 1
						}
					}) {
						Image(systemName: "arrow.forward")
					}
          .disabled(selectedIndex == trip.days.count - 1)
				}
				.padding(.horizontal)
				.padding(.bottom, 10)
				
				// Main content needs to scroll
				ScrollView {
					// Itinerary section
          ItineraryView(day: trip.days[selectedIndex])
					
					// Add to Itinerary section
					Text("Add to Itinerary")
						.font(.title2)
						.fontWeight(.semibold)
						.padding(.leading, 20)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					TextField("Search for a place", text: $searchText)
						.padding()
						.background(Color(.systemGray5))
						.cornerRadius(10)
						.padding(.horizontal, 20)
						.padding(.bottom, 10)
					
					// Map section
					Text("Map")
						.font(.title2)
						.fontWeight(.semibold)
						.padding(.leading, 20)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					Rectangle()
						.fill(Color(.systemGray6))
						.frame(height: 200)
						.cornerRadius(10)
						.padding(.horizontal, 20)
					
					Spacer()
				}
			} else {
				Text("Loading days...")
					.font(.subheadline)
					.foregroundColor(.gray)
					.padding()
			}
		}
	}
	
}

struct TripDetailsView_Previews: PreviewProvider {
  static var previews: some View {
		TripDetailsView(trip: Trip.example)
  }
}
