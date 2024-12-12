//
//  ItineraryView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/6.
//

import SwiftUI

// View for displaying the itinerary of a single day in a trip
struct ItineraryView: View {
  var day: Day
  let hourHeight: CGFloat = 50
  let trip: Trip
  @ObservedObject var tripRepository: TripRepository
  let dayNumber: Int
  
  var body: some View {
    VStack(alignment: .leading) {
      // Section Title
      Text("Itinerary")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      // Scrollable hourly schedule
      Rectangle()
        .fill(Color("LightPurple"))
        .frame(height: 300)
        .overlay(
          ScrollViewReader { proxy in
            ScrollView {
              VStack(alignment: .leading, spacing: 0) {
                // Iterate through each hour to create hourly rows
                ForEach(0..<24, id: \.self) { hour in
                  HourRow(hour: hour, hourHeight: hourHeight)
                    .id(hour)
                    .overlay(
                      VStack {
                        // Add events to the correct hour row
                        ForEach(day.events) { event in
                          if let startTime = event.startTimeAsDate() {
                            let startHour = Calendar.current.component(.hour, from: startTime)
                            if startHour == hour {
                              EventRow(event: event, trip: trip, tripRepository: tripRepository, dayNumber: dayNumber)
                                .frame(height: calculateEventHeight(event: event))
                                .offset(x: 60, y: calculateDiff(event: event) + calculateEventOffset(event: event, hourHeight: hourHeight))
                            }
                          }
                        }
                      }
                    )
                }
              }
              .frame(height: hourHeight * 24)
              .onAppear {
                proxy.scrollTo(7, anchor: .top)
              }
            }
          }
        )
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    .padding(.bottom, 10)
  }
  
  // Calculate the difference in vertical alignment for an event based on its duration
  private func calculateDiff(event: Event) -> CGFloat {
    guard let start = event.startTimeAsDate(), let end = event.endTimeAsDate() else { return hourHeight }
    let duration = end.timeIntervalSince(start)
    return CGFloat(duration / 3600) * hourHeight / 2
  }

  // Calculate the height of an event block based on its duration
  private func calculateEventHeight(event: Event) -> CGFloat {
    guard let start = event.startTimeAsDate(), let end = event.endTimeAsDate() else { return hourHeight }
    let duration = end.timeIntervalSince(start)
    return CGFloat(duration / 3600) * hourHeight
  }

  // Calculate the vertical offset for an event based on its start time
  private func calculateEventOffset(event: Event, hourHeight: CGFloat) -> CGFloat {
    guard let start = event.startTimeAsDate() else { return 0 }
    let minutes = Calendar.current.component(.minute, from: start)
    return CGFloat(minutes) / 60 * hourHeight
  }
}

// A row representing a single hour in the itinerary
struct HourRow: View {
  var hour: Int
  let hourHeight: CGFloat
  
  var body: some View {
    HStack {
      // Hour label
      Text("\(String(format: "%02d", hour)):00")
        .font(.subheadline)
        .foregroundColor(.gray)
        .frame(width: 50, alignment: .trailing)

      // Line across the row
      Rectangle()
        .fill(Color.gray.opacity(0.4))
        .frame(height: 0.5)
    }
    .frame(height: hourHeight)
  }
}

// Reusable EventRow component for each event in the itinerary
struct EventRow: View {
  var event: Event
  let trip: Trip
  let tripRepository: TripRepository
  let dayNumber: Int
  
  var body: some View {
    ZStack(alignment: .leading) {
      // Background rectangle for the event
      Rectangle()
        .fill(Color.blue.opacity(0.1))
        .cornerRadius(8)
      
      // Navigation link to edit the event
      NavigationLink(destination: EditEventView(event: event, trip: trip, tripRepository: tripRepository, dayNumber: dayNumber)) {
        // Event details
        VStack(alignment: .leading, spacing: 2) {
          Text(event.title)
            .font(.body)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
          
          Text("\(event.startTime) - \(event.endTime)")
            .font(.caption)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(7)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}
