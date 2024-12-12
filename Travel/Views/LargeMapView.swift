//
//  LargeMapView.swift
//  Travel
//
//  Created by Kailan Mao on 12/1/24.
//

import SwiftUI
import CoreLocation
import MapKit

// View for displaying a large map  for events on a specific day of a trip
struct LargeMapView: View {
  @State private var selectedEvent: Event? = nil
  var day: Day
  @State var region: MKCoordinateRegion
  var trip: Trip
  var dayNumber: Int
  @ObservedObject var tripRepository: TripRepository
  
  var body: some View {
    VStack {
      NavigationStack {
        // Map view with annotations for each event
        Map(coordinateRegion: $region, annotationItems: day.events) { event in
          MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(event.latitude), longitude: CLLocationDegrees(event.longitude))) {
            Button(action: {
              selectedEvent = event
            }) {
              ZStack {
                // Red map pin
                Image(systemName: "mappin.circle.fill")
                  .foregroundColor(.red)
                  .font(.title3)
                  .frame(width: 10, height: 10)
                Text(event.title)
                  .font(.caption.bold())
                  .foregroundColor(.black)
              }
            }
          }
        }
        .ignoresSafeArea()
        .navigationDestination(for: Location.self) { location in
          LocationDetailView(location: location, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)
        }
      }
      // Overlay pop-up view when an event is selected
      .overlay(
        selectedEvent != nil ? popUpView : nil,
        alignment: .bottom
      )
    }
  }
  
  // Pop-up view to display details of the selected event
  private var popUpView: some View {
    VStack(spacing: 5) {
      Text(selectedEvent?.title ?? "")
        .font(.headline)
        .foregroundColor(.primary)
      Text(selectedEvent?.location ?? "")
        .font(.subheadline)
        .foregroundColor(.gray)
      Text(selectedEvent?.address ?? "")
        .font(.footnote)
      Button(action: {
        selectedEvent = nil
      }) {
        Text("Close")
          .font(.footnote.bold())
          .foregroundColor(.accentColor)
      }
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 5)
  }
}
