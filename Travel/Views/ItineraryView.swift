//
//  ItineraryView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/6.
//

import SwiftUI

struct ItineraryView: View {
  var day: Day
  var tripId: String
  var dayId: String
  @ObservedObject var tripRepository: TripRepository
  let hourHeight: CGFloat = 50 // Height representing one hour
  

  var body: some View {
    VStack(alignment: .leading) {
      // Itinerary section header
      Text("Itinerary")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)

      // Calendar view within a fixed rectangle
      Rectangle()
        .fill(Color(.systemGray6))
        .frame(height: 300) // Fixed height for the "calendar" rectangle
        .overlay(
          ScrollView {
            VStack(alignment: .leading, spacing: 0) {
              // Hour lines and labels
              ForEach(0..<24, id: \.self) { hour in
                HourRow(hour: hour, hourHeight: hourHeight)
                  .overlay(
                    // Add events that start within the current hour
                    VStack {
                      ForEach(day.events) { event in
                        if let startTime = event.startTimeAsDate() {
                          
                          let startHour = Calendar.current.component(.hour, from: startTime)
                          
                          // If the event starts in the current hour
                          if startHour == hour {
                            NavigationLink(
                              destination: EditEventView(tripRepository: tripRepository, tripId: tripId, dayId: dayId, event: event)
                            ) {
                              EventRow(event: event)
                                .frame(height: calculateEventHeight(event: event))
                                .offset(x: 60, y: calculateDiff(event: event) + calculateEventOffset(event: event, hourHeight: hourHeight))
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevents default navigation link style
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

  // Calculate the height of an event based on its duration
  private func calculateEventHeight(event: Event) -> CGFloat {
    guard let start = event.startTimeAsDate(), let end = event.endTimeAsDate() else { return hourHeight }
    let duration = end.timeIntervalSince(start)
    return CGFloat(duration / 3600) * hourHeight
  }

  // Calculate the vertical offset of the event within its hour block
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

  var body: some View {
    ZStack(alignment: .leading) {
      // Background rectangle filling the entire row
      Rectangle()
        .fill(Color.blue.opacity(0.1))
        .cornerRadius(8)

      // Event details on top of the background rectangle
      VStack(alignment: .leading, spacing: 2) {
        Text(event.locationName)
          .font(.body)
          .fontWeight(.medium)

        Text("\(event.startTime) - \(event.endTime)")
          .font(.caption)
          .foregroundColor(.gray)
      }
      .padding(7)
    }
    .frame(maxWidth: .infinity)
  }
}

extension Event {
  // Helper to convert event start time to a Date object
  func startTimeAsDate() -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.date(from: startTime)
  }

  // Helper to convert event end time to a Date object
  func endTimeAsDate() -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter.date(from: endTime)
  }
}

struct ItineraryView_Previews: PreviewProvider {
  static var previews: some View {
    ItineraryView(day: Day.example1, tripId: "exampleTripId", dayId: "exampleDayId", tripRepository: TripRepository())
  }
}
