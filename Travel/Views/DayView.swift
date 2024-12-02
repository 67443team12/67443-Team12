//
//  DayView.swift
//  kailan-team12
//
//  Created by Kailan Mao on 11/4/24.
//

import SwiftUI
import CoreLocation
import MapKit

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

  
  // Initializer
  init(trip: Trip, day: Day, dayNumber: Int, locationRepository: LocationRepository, tripRepository: TripRepository) {
      self.trip = trip
      self.day = day
      self.dayNumber = dayNumber
      self.locationRepository = locationRepository
      self.tripRepository = tripRepository
      
      // Default region
      var initialRegion = MKCoordinateRegion(
          center: CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795),
          span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
      )
      
      // Update region based on the first event, if available
      if let firstEvent = day.events.first {
          initialRegion.center = CLLocationCoordinate2D(latitude: firstEvent.latitude, longitude: firstEvent.longitude)
          initialRegion.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1) // Adjust for zoom level
      }
      
      _region = State(initialValue: initialRegion)
  }
  
  
  
  
  var body: some View {
    @State var selectedLocation: Location?

    let binding = Binding<String>(get: {
      self.searchText
    }, set: {
      self.searchText = $0
      self.locationRepository.search(searchText: self.searchText)
      self.displayLocations()
    })

    VStack {
      // Itinerary section
      ItineraryView(day: day, trip: trip, tripRepository: tripRepository, dayNumber: dayNumber)

      // Add to Itinerary section
      Text("Add to Itinerary")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)

      // Search bar with clear button inside the gray rectangle
      HStack {
        TextField("Search for a place", text: binding)
          .padding(.leading, 10) // Extra padding for text
          .padding(.vertical, 15)
        
        if !searchText.isEmpty {
          Button(action: {
            searchText = ""
            displayLocations() // Update displayedLocations after clearing
          }) {
            Image(systemName: "xmark.circle.fill")
              .foregroundColor(.gray)
          }
          .padding(.trailing, 10)
        }
      }
      .background(Color(.systemGray5))
      .cornerRadius(10)
      .padding(.horizontal, 20)
      .padding(.bottom, 10)

      // Map section
      if searchText != "" {
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
//                        Text(location.description)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
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

        Text("Map")
          .font(.title2)
          .fontWeight(.semibold)
          .padding(.leading, 20)
          .frame(maxWidth: .infinity, alignment: .leading)

      
      NavigationLink(destination: LargeMapView(day: day, region: region, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)) {
          Text("View Enlarged Map")
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

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
      .frame(width: 350, height: 300)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(
        selectedEvent != nil ? popUpView : nil,
        alignment: .bottom
      )

      Spacer()
    }
    .onAppear {
      loadData()
      setRegion(events: day.events)
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

  private func loadData() {
    self.displayedLocations = []
  }
  
  func setRegion(events: [Event]) {
      guard let firstEvent = events.first else {
          print("No events available to set the region.")
          return
      }
      
      let center = CLLocationCoordinate2D(latitude: firstEvent.latitude, longitude: firstEvent.longitude)
      let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust for desired zoom level
      
      region = MKCoordinateRegion(center: center, span: span)
  }

  private func printLocations(locations: [Location]) -> String {
    let locationNames = locations.map { $0.name }
    return locationNames.joined(separator: "\n")
  }

  private func generateLocations(events: [Event]) -> [CLLocationCoordinate2D] {
    return events.map { event in
      CLLocationCoordinate2D(latitude: CLLocationDegrees(event.latitude),
                             longitude: CLLocationDegrees(event.longitude))
    }
  }

  private func displayLocations() {
    if searchText == "" {
      displayedLocations = []
      locationRepository.filteredLocations = []
    } else {
      displayedLocations = locationRepository.filteredLocations
    }
  }

  private func getEventCoords(events: [Event]) -> [Event] {
    return events
  }

  private func printEvents(events: [Event]) -> String {
    let eventNames = events.map { $0.title }
    return eventNames.joined(separator: "\n")
  }

  private func eventToString(event: Event) -> String {
    return "\(event.title): \(event.startTime) -- \(event.endTime)"
  }

  func sortEventsByStartTime(events: [Event]) -> [Event] {
    return events.sorted { (event1, event2) -> Bool in
      guard let date1 = event1.startTimeAsDate(), let date2 = event2.startTimeAsDate() else {
        return false
      }
      return date1 < date2
    }
  }
}
