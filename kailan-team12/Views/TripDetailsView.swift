//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripDetailsView: View {
  var trip: Trip
  var tripRepository: TripRepository
  
  @State private var currentIndex = 0
  @ObservedObject var locationRepository = LocationRepository()
      
  var body: some View {
    ScrollView {
    VStack {
      // Navigation controls
      Spacer()
      
      // Display the current DayView based on the current index
      if !trip.days.isEmpty {
        HStack {
          // Left arrow to go back
          Button(action: {
            if currentIndex > 0 {
              currentIndex -= 1
            }
          }) {
            Image(systemName: "arrow.left")
              .font(.largeTitle)
          }
          .disabled(currentIndex == 0) // Disable button if on the first day
          
          Spacer()
          
          // Right arrow to go forward
          Button(action: {
            if currentIndex < trip.days.count - 1 {
              currentIndex += 1
            }
          }) {
            Image(systemName: "arrow.right")
              .font(.largeTitle)
          }
          .disabled(currentIndex == trip.days.count - 1) // Disable button if on the last day
        }
        .padding()
        DayView(trip: trip, day: trip.days[currentIndex], dayNumber: currentIndex + 1, locationRepository: locationRepository, tripRepository: tripRepository)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .transition(.slide)
        
        
      } else {
        Text("empty days.")
      }
    }
    .animation(.easeInOut, value: currentIndex)
  }
      }
  }
  


