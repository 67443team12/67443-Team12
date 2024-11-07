//
//  EditEventView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/6.
//

import SwiftUI

struct EditEventView: View {
  let event: Event
  let trip: Trip
  let tripRepository: TripRepository
  let dayNumber: Int
  
  @State private var startTime: Date
  @State private var endTime: Date
  @State private var eventName: String
	
	@Environment(\.presentationMode) var presentationMode

  init(event: Event, trip: Trip, tripRepository: TripRepository, dayNumber: Int) {
    self.event = event
    self.trip = trip
    self.tripRepository = tripRepository
    self.dayNumber = dayNumber
    _startTime = State(initialValue: EditEventView.dateFromString(event.startTime) ?? Date())
    _endTime = State(initialValue: EditEventView.dateFromString(event.endTime) ?? Date())
    _eventName = State(initialValue: event.title)
  }

  var body: some View {
    Form {
      Section(header: Text("Location: \(event.location)").font(.headline)) {
        TextField("Enter event name", text: $eventName)

          .padding(.vertical, 10)
        
        HStack {
          Text("Start Time")
            .font(.headline)
          Spacer()
          DatePicker("", selection: $startTime, displayedComponents: [.hourAndMinute])
            .labelsHidden()
        }
        .padding(.bottom, 10)
        
        HStack {
          Text("End Time")
            .font(.headline)
          Spacer()
          DatePicker("", selection: $endTime, displayedComponents: [.hourAndMinute])
            .labelsHidden()
        }
        .padding(.bottom, 20)
        
        Button("Save Event") {
          let updatedEvent = Event(
            id: event.id,
            startTime: formatTime(date: startTime),
            endTime: formatTime(date: endTime),
            ratings: event.ratings,
            latitude: event.latitude,
            longitude: event.longitude,
            image: event.image,
            location: event.location,
            title: eventName,
            duration: event.duration,
            address: event.address,
            monday: event.monday,
            tuesday: event.tuesday,
            wednesday: event.wednesday,
            thursday: event.thursday,
            friday: event.friday,
            saturday: event.saturday,
            sunday: event.sunday
          )
          
          tripRepository.editEventInTrip(trip: trip, dayIndex: dayNumber - 1, eventId: event.id, updatedEvent: updatedEvent)
//  			Tried to dismiss the view after saving the event, but then the view would not update
//					presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
  
  private func formatTime(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm" // 24-hour format
    return dateFormatter.string(from: date)
  }

  static func dateFromString(_ timeString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm" // 24-hour format
    return formatter.date(from: timeString)
  }
}
