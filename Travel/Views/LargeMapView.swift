//
//  LargeMapView.swift
//  Travel
//
//  Created by k mao on 12/1/24.
//

import SwiftUI
import CoreLocation
import MapKit

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
          Map(coordinateRegion: $region, annotationItems: day.events) { event in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(event.latitude), longitude: CLLocationDegrees(event.longitude))) {
              Button(action: {
                selectedEvent = event
              }) {
                ZStack {
                  Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.red)
                    .font(.title3) // Make the red pin smaller
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
//        .frame(width: 350, height: 300)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
          selectedEvent != nil ? popUpView : nil,
          alignment: .bottom
        )
      }
    }
  
  private var popUpView: some View {
    VStack(spacing: 5) {
      Text(selectedEvent?.title ?? "") // Display event title
        .font(.headline)
        .foregroundColor(.primary)
      Text(selectedEvent?.location ?? "")
        .font(.subheadline)
        .foregroundColor(.gray)
      Text(selectedEvent?.address ?? "")
        .font(.footnote)
      Button(action: {
        selectedEvent = nil // Close pop-up
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

