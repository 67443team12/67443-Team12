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
  @State private var startTime = "8:00 AM"
  @State private var endTime = "9:20 AM"
//  @State private var isPresented: Bool
  
  
  var body: some View {
    Text("hufidsjcnkm")
    Button("add dummy to firebse") {
      let newEvent = Event(
          id: UUID().uuidString,
          startTime: "8:00 AM",
          endTime: "9:20 AM",
          rating: 0.0,
          latitude: 37.7749,
          longitude: -122.4194,
          image: "path/to/image.jpg",
          name: "Central Park"
      )
      
      tripRepository.addEventToTrip(trip: trip, dayIndex: dayNumber - 1, event: newEvent)
    }
    
  }
  
  }



