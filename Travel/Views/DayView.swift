//
//  DayView.swift
//  Travel
//
//  Created by k mao on 11/4/24.
//

import SwiftUI

struct DayView: View {
	let day: Day // Replace `String` with your `Day` model type if it's more complex
	@Binding var searchText: String

	var body: some View {
		ScrollView {
			// Itinerary section
			Text("Itinerary")
				.font(.title2)
				.fontWeight(.semibold)
				.padding(.leading, 20)
				.frame(maxWidth: .infinity, alignment: .leading)
			
			Rectangle()
				.fill(Color(.systemGray6))
				.frame(height: 200)
				.cornerRadius(10)
				.padding(.horizontal, 20)
				.padding(.bottom, 10)
			
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
	}
}
