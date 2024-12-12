//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

// View for displaying the detail of a trip
struct TripDetailsView: View {
  var trip: Trip
  @ObservedObject var tripRepository: TripRepository
  @State private var selectedIndex = 0
  var locationRepository: LocationRepository
  @ObservedObject var userRepository: UserRepository

  var body: some View {
    VStack {
      // Trip name displayed as a centered header
      HStack {
        Text(trip.name)
          .font(.largeTitle)
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .center)
      }

      // Navigation for days
      if !trip.days.isEmpty {
        HStack {
          // Backward navigation button
          Button(action: {
            if selectedIndex > 0 {
              selectedIndex -= 1
            }
          }) {
            Image(systemName: "arrow.backward")
          }
          .disabled(selectedIndex == 0)
          
          Spacer()

          // Current day label
          Text("Day \(selectedIndex + 1): \(trip.days[selectedIndex].formattedDate)")
            .font(.headline)
            .padding()
            .background(Color("LightPurple"))
            .cornerRadius(10)

          Spacer()

          // Forward navigation button
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

        // Day content view with horizontal swipe navigation
        GeometryReader { geometry in
          HStack(spacing: 0) {
            ForEach(0..<trip.days.count, id: \.self) { index in
              ScrollView {
                // DayView displays details for a specific day
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
        .clipped()
      } else {
        Text("Loading days...")
          .font(.subheadline)
          .foregroundColor(.gray)
          .padding()
      }
    }
    // Toolbar with navigation to CompanionsView
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(
          destination: CompanionsView(trip: trip, tripRepository: tripRepository, userRepository: userRepository)
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
    .background(Color("Cream"))
  }
}
