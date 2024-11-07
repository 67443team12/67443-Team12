//
//  ItineraryView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/6.
//

import SwiftUI

struct ItineraryView: View {
  var day: Day
  let hourHeight: CGFloat = 50
  let trip: Trip
  @ObservedObject var tripRepository: TripRepository
  let dayNumber: Int
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Itinerary")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Rectangle()
        .fill(Color(.systemGray6))
        .frame(height: 300)
        .overlay(
          ScrollView {
            VStack(alignment: .leading, spacing: 0) {
              ForEach(0..<24, id: \.self) { hour in
                HourRow(hour: hour, hourHeight: hourHeight)
                  .overlay(
                    VStack {
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
          }
        )
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    .padding(.bottom, 10)
  }
  
  private func calculateDiff(event: Event) -> CGFloat {
    guard let start = event.startTimeAsDate(), let end = event.endTimeAsDate() else { return hourHeight }
    let duration = end.timeIntervalSince(start)
    return CGFloat(duration / 3600) * hourHeight / 2
  }

  private func calculateEventHeight(event: Event) -> CGFloat {
    guard let start = event.startTimeAsDate(), let end = event.endTimeAsDate() else { return hourHeight }
    let duration = end.timeIntervalSince(start)
    return CGFloat(duration / 3600) * hourHeight
  }

  private func calculateEventOffset(event: Event, hourHeight: CGFloat) -> CGFloat {
    guard let start = event.startTimeAsDate() else { return 0 }
    let minutes = Calendar.current.component(.minute, from: start)
    return CGFloat(minutes) / 60 * hourHeight
  }
}

// Hourly Row with a line and label for each hour
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
        // Background rectangle filling the entire row
        Rectangle()
          .fill(Color.blue.opacity(0.1))
          .cornerRadius(8)
        
        NavigationLink(destination: EditEventView(event: event, trip: trip, tripRepository: tripRepository, dayNumber: dayNumber)) {
          // Event details on top of the background rectangle
          VStack(alignment: .leading, spacing: 2) { // Align text to the left
            Text(event.title)
              .font(.body)
              .fontWeight(.medium)
              .frame(maxWidth: .infinity, alignment: .leading) // Ensure alignment is left
            
            Text("\(event.startTime) - \(event.endTime)")
              .font(.caption)
              .foregroundColor(.gray)
              .frame(maxWidth: .infinity, alignment: .leading) // Ensure alignment is left
          }
          .padding(7)
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Align the entire link to the left
      }
  }
}
