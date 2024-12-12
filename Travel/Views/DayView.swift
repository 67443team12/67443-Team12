//
//  DayView.swift
//  Travel
//
//  Created by Kailan Mao on 11/4/24.
//

import SwiftUI
import CoreLocation
import MapKit

// View for displaying a specific day's itinerary, search functionality, and map
struct DayView: View {
  let trip: Trip
  let day: Day
  let dayNumber: Int
  let locationRepository: LocationRepository
  let tripRepository: TripRepository
  @State var displayedLocations: [Location] = [Location]()
  @State var searchText: String = ""
  @State var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795),
    span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
  )
  @State private var selectedEvent: Event? = nil

  // Initializer to set the default region based on the first event of the day
  init(trip: Trip, day: Day, dayNumber: Int, locationRepository: LocationRepository, tripRepository: TripRepository) {
    self.trip = trip
    self.day = day
    self.dayNumber = dayNumber
    self.locationRepository = locationRepository
    self.tripRepository = tripRepository
    
    // Adjust region based on the first event if available
    var initialRegion = MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795),
      span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
    )
    if let firstEvent = day.events.first {
      initialRegion.center = CLLocationCoordinate2D(latitude: firstEvent.latitude, longitude: firstEvent.longitude)
      initialRegion.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    }
    _region = State(initialValue: initialRegion)
  }
  
  var body: some View {
    let binding = Binding<String>(get: {
      self.searchText
    }, set: {
      self.searchText = $0
      self.locationRepository.search(searchText: self.searchText)
      self.displayLocations()
    })

    VStack {
      // Itinerary section for the day's events
      ItineraryView(day: day, trip: trip, tripRepository: tripRepository, dayNumber: dayNumber)

      // Add to Itinerary section
      Text("Add to Itinerary")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)

      // Search bar for locations
      HStack {
        TextField("Search for a place", text: binding)
          .padding(.leading, 10)
          .padding(.vertical, 15)
        
        // Clear button for the search bar
        if !searchText.isEmpty {
          Button(action: {
            searchText = ""
            displayLocations()
          }) {
            Image(systemName: "xmark.circle.fill")
              .foregroundColor(.gray)
          }
          .padding(.trailing, 10)
        }
      }
      .background(Color("LightPurple"))
      .cornerRadius(10)
      .padding(.horizontal, 20)
      .padding(.bottom, 10)

      // Display search results if searchText is not empty
      if !searchText.isEmpty {
        Text("Search Results")
          .font(.title2)
          .fontWeight(.semibold)
          .padding(.leading, 20)
          .frame(maxWidth: .infinity, alignment: .leading)

        NavigationStack {
          List(displayedLocations, id: \.id) { location in
            NavigationLink(destination: LocationDetailView(location: location, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)) {
              VStack(alignment: .leading) {
                Text(location.name)
                  .font(.headline)
              }
            }
          }
          .listStyle(.inset)
        }
        .frame(width: 350, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .stroke(.gray, lineWidth: 1)
        )
      }

      // Map section header
      Text("Map")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)

      // Link to enlarged map view
      NavigationLink(destination: LargeMapView(day: day, region: region, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)) {
        Text("View Enlarged Map")
          .font(.subheadline)
          .foregroundColor(.gray)
          .padding(.leading, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      // Map displaying the day's events
      NavigationStack {
        Map(coordinateRegion: $region, annotationItems: day.events) { event in
          MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)) {
            Button(action: {
              selectedEvent = event
            }) {
              ZStack {
                Image(systemName: "mappin.circle.fill")
                  .foregroundColor(.red)
                  .font(.title3)
                Text(event.title)
                  .font(.caption.bold())
                  .foregroundColor(.black)
              }
            }
          }
        }
        .ignoresSafeArea()
      }
      .frame(width: 350, height: 450)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(
        selectedEvent != nil ? popUpView : nil,
        alignment: .bottom
      )

      Spacer()
    }
    .onAppear {
      displayLocations()
      setRegion(events: day.events)
    }
  }

  // Pop-up view for a selected event
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

  // Update the map region based on the first event
  private func setRegion(events: [Event]) {
    guard let firstEvent = events.first else { return }
    let center = CLLocationCoordinate2D(latitude: firstEvent.latitude, longitude: firstEvent.longitude)
    region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
  }

  // Update displayed locations based on the search results
  private func displayLocations() {
    displayedLocations = searchText.isEmpty ? [] : locationRepository.filteredLocations
  }
}
