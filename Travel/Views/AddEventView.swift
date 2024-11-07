//
//  AddEventView.swift
//  kailan-team12
//
//  Created by Kailan Mao on 11/5/24.
//

import SwiftUI

struct AddEventView: View {
  let location: Location
  let trip: Trip
  let dayNumber: Int
  let tripRepository: TripRepository
  @State private var startTime = Date()
  @State private var endTime = Date()
  @State private var eventName = ""
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    VStack(alignment: .leading) {
      // Back and Save buttons in a single line
      HStack(alignment: .center) {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          HStack {
            Image(systemName: "chevron.left")
              .font(.title3)
              .fontWeight(.medium)
            Text("Back")
              .font(.title3)
              .fontWeight(.medium)
          }
          .foregroundColor(.accentColor)
        }

        Spacer()

        Button(action: {
          let newEvent = Event(
            id: UUID().uuidString,
            startTime: formatTime(date: startTime),
            endTime: formatTime(date: endTime),
            ratings: location.ratings,
            latitude: location.latitude,
            longitude: location.longitude,
            image: location.image,
            location: location.name,
            title: eventName,
            duration: location.duration,
            address: location.address,
            monday: location.monday,
            tuesday: location.tuesday,
            wednesday: location.wednesday,
            thursday: location.thursday,
            friday: location.friday,
            saturday: location.saturday,
            sunday: location.sunday
          )
          
          tripRepository.addEventToTrip(trip: trip, dayIndex: dayNumber - 1, event: newEvent)
          presentationMode.wrappedValue.dismiss() // Dismiss view after saving
        }) {
          Text("Save")
            .font(.title3)
            .fontWeight(.medium)
            .foregroundColor(.accentColor)
        }
        .foregroundColor(eventName.isEmpty ? .gray : .blue)
        .disabled(eventName.isEmpty)
      }
      .padding([.leading, .trailing, .top], 20)
      .padding(.bottom, 10)

      // Title
      Text("Add to Schedule")
        .font(.title)
        .fontWeight(.bold)
        .padding(.horizontal)
        .padding(.bottom, 20)

      // Event name input
      TextField("Enter event name", text: $eventName)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal, 20)
        .padding(.bottom, 10)

      // Start time picker
      HStack {
        Text("Start Time")
          .font(.headline)
        Spacer()
        DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
          .labelsHidden()
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 10)

      // End time picker
      HStack {
        Text("End Time")
          .font(.headline)
        Spacer()
        DatePicker("", selection: $endTime, displayedComponents: [.hourAndMinute])
          .labelsHidden()
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 20)

      Spacer()
    }
    .navigationBarBackButtonHidden(true)
  }
  
  private func formatTime(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm" // 24-hour format
    return dateFormatter.string(from: date)
  }
}
