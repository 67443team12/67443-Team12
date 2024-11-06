//
//  EditEventView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/6.
//

import SwiftUI

struct EditEventView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var tripRepository: TripRepository
  var tripId: String
  var dayId: String
  @State var event: Event

  @State private var startDate = Date()
  @State private var endDate = Date()
  @State private var showStartPicker = false
  @State private var showEndPicker = false

  var body: some View {
    Form {
      Section(header: Text("Event Details")) {
        TextField("Location Name", text: $event.locationName)
        
        // Start Time
        HStack {
          Text("Start Time")
          Spacer()
          Text(timeFormatter.string(from: startDate))
            .foregroundColor(.accentColor)
            .onTapGesture {
              withAnimation {
                showStartPicker.toggle()
                if showEndPicker { showEndPicker = false }
              }
            }
        }

        if showStartPicker {
          DatePicker("Start Time", selection: $startDate, displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
            .onChange(of: startDate) { newValue in
              event.startTime = timeFormatter.string(from: newValue)
            }
        }

        // End Time
        HStack {
          Text("End Time")
          Spacer()
          Text(timeFormatter.string(from: endDate))
            .foregroundColor(.accentColor)
            .onTapGesture {
              withAnimation {
                showEndPicker.toggle()
                if showStartPicker { showStartPicker = false }
              }
            }
        }

        if showEndPicker {
          DatePicker("End Time", selection: $endDate, displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
            .onChange(of: endDate) { newValue in
              event.endTime = timeFormatter.string(from: newValue)
            }
        }
      }

      // Save Button
      Button(action: {
        tripRepository.updateEvent(tripId: tripId, dayId: dayId, updatedEvent: event)
        presentationMode.wrappedValue.dismiss()
      }) {
        Text("Save")
      }
      .disabled(event.locationName.isEmpty || event.startTime.isEmpty || event.endTime.isEmpty)

      // Delete Button
      Button(action: {
        tripRepository.deleteEvent(tripId: tripId, dayId: dayId, eventId: event.id)
        presentationMode.wrappedValue.dismiss()
      }) {
        Text("Delete Event")
          .foregroundColor(.red)
      }
    }
    .navigationTitle("Edit Event")
    .navigationBarItems(trailing: Button("Cancel") {
      presentationMode.wrappedValue.dismiss()
    })
    .onAppear {
      if let startTimeDate = timeFormatter.date(from: event.startTime) {
        startDate = startTimeDate
      }
      if let endTimeDate = timeFormatter.date(from: event.endTime) {
        endDate = endTimeDate
      }
    }
  }

  private var timeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    return formatter
  }
}

struct EditEventView_Previews: PreviewProvider {
  static var previews: some View {
    EditEventView(
      tripRepository: TripRepository(),
      tripId: "sampleTripId",
      dayId: "sampleDayId",
      event: Event.example1
    )
  }
}
