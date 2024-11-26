//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripDetailsView: View {
  var trip: Trip
	@ObservedObject var tripRepository: TripRepository
  @State private var selectedIndex = 0
	var locationRepository: LocationRepository
	
//	@EnvironmentObject var aliceVM: MockUser
	var currUser: User

  var body: some View {
    VStack {
      HStack {
        Text(trip.name)
          .font(.largeTitle)
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .center)
      }
      
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
				
				GeometryReader { geometry in
					HStack(spacing: 0) {
						ForEach(0..<trip.days.count, id: \.self) { index in
							ScrollView {
								DayView(
									trip: trip,
									day: trip.days[index],
									dayNumber: index + 1,
									locationRepository: locationRepository,
									tripRepository: tripRepository
								)
								.frame(width: geometry.size.width)
							}
						}
					}
					.offset(x: -CGFloat(selectedIndex) * geometry.size.width)
					.animation(.easeInOut, value: selectedIndex)
				}
				.clipped() // Prevents content overflow
			} else {
        Text("Loading days...")
          .font(.subheadline)
          .foregroundColor(.gray)
          .padding()
      }
    }
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				NavigationLink(
					destination: CompanionsView(trip: trip, tripRepository: tripRepository, currUser: currUser)
				) {
					VStack(spacing: 2) {
						Image(systemName: "person.3")
							.font(.headline)
							.fontWeight(.semibold)
						Text("Companions")
							.font(.caption2)
							.fontWeight(.semibold)
					}
				}
			}
		}
  }
}

//struct TripDetailsView_Previews: PreviewProvider {
//  static var previews: some View {
//		TripDetailsView(trip: Trip.example, tripRepository: TripRepository())
//  }
//}
