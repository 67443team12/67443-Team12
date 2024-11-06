//
//  AddEventView.swift
//  kailan-team12
//
//  Created by k mao on 11/5/24.
//

import SwiftUI

struct AddEventView: View {
  let location: Location
  let trip: Trip
  let dayNumber: Int
  let tripRepository: TripRepository
//  let dayIndex: Int
  @State private var startTime = Date()
  @State private var endTime = Date()
//  @State private var isPresented: Bool
  
  
  var body: some View {
    Text("Add to Schedule")
      .font(.title2)
      .fontWeight(.bold)
      .padding(.bottom, 10)
    
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
    
    Button("add dummy to firebse") {
      let newEvent = Event(
          id: UUID().uuidString,
          startTime: formatTime(date: startTime),
          endTime: formatTime(date: endTime),
          rating: location.ratings,
          latitude: location.latitude,
          longitude: location.longitude,
          image: location.image,
          name: location.name
      )
      
      tripRepository.addEventToTrip(trip: trip, dayIndex: dayNumber - 1, event: newEvent)
    }
    
  }
  
  private func formatTime(date: Date) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "hh:mm a"
      return dateFormatter.string(from: date)

  }
  
  }



