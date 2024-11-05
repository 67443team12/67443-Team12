//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripDetailsView: View {
  var trip: Trip
//  @State private var days: [String] = []
  @State private var searchText: String = ""
  @State private var currentIndex = 0
      
      var body: some View {
          VStack {
            // Navigation controls
            
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
              DayView(day: trip.days[currentIndex])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.slide)
                

            } else {
              Text("emoty days.")
            }
          }
          .animation(.easeInOut, value: currentIndex)
      }
  }
  


