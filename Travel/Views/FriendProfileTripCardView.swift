//
//  FriendProfileTripCardView.swift
//  Travel
//
//  Created by Emma Shi on 11/25/24.
//

import SwiftUI

struct FriendProfileTripCardView: View {
	@State var trip: Trip
	@ObservedObject var tripRepository: TripRepository
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack(alignment: .bottomTrailing) {
				// Display image or color gradient
				AsyncImage(url: URL(string: trip.photo)) { image in
					image.resizable()
				} placeholder: {
					getGradient(from: trip.color)
				}
				.frame(height: 150)
				.clipShape(
						.rect(
								topLeadingRadius: 15,
								bottomLeadingRadius: 0,
								bottomTrailingRadius: 0,
								topTrailingRadius: 15
						)
				)
			}
			// Display trip name and dates
			Text(trip.name)
				.font(.title3.bold())
				.padding([.leading])
				.padding(.top, 6)
				.foregroundColor(.black)
			
			Text("\(trip.startDate) - \(trip.endDate)")
				.font(.subheadline)
				.foregroundColor(.gray)
				.padding([.leading, .bottom])
		}
		.background(Color.white)
		.cornerRadius(15)
		.shadow(radius: 5)
	}
	
	func getColor(from colorName: String) -> Color {
		switch colorName.lowercased() {
		case "blue": return Color.blue
		case "red": return Color.red
		case "green": return Color.green
		case "yellow": return Color.yellow
		case "purple": return Color.purple
		case "orange": return Color.orange
		case "gray": return Color.gray
		default: return Color.gray // Fallback color
		}
	}
	
	func getGradient(from colorName: String) -> LinearGradient {
		let color = getColor(from: colorName)
		let lighterColor = color.opacity(0.4)
		return LinearGradient(
			gradient: Gradient(colors: [lighterColor, color]),
			startPoint: .top,
			endPoint: .bottom
		)
	}
}

#Preview {
    FriendProfileTripCardView(trip: Trip.example, tripRepository: TripRepository())
}
