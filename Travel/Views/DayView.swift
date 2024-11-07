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
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795),
    span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
  )

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

      TextField("Search for a place", text: binding)
        .padding()
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
          Map(coordinateRegion: $region, annotationItems: displayedLocations) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))) {
              NavigationLink(destination: LocationDetailView(location: location, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)) {
                ZStack {
                  Circle()
                    .fill(.blue)
                    .frame(width: 15, height: 15)
                  Text(location.name)
                    .font(.caption)
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
          RoundedRectangle(cornerRadius: 20)
            .stroke(.gray, lineWidth: 1)
        )
      }

      Text("Map")
        .font(.title2)
        .fontWeight(.semibold)
        .padding(.leading, 20)
        .frame(maxWidth: .infinity, alignment: .leading)

      NavigationStack {
        Map(coordinateRegion: $region, annotationItems: day.events) { event in
          MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(event.latitude), longitude: CLLocationDegrees(event.longitude))) {
            ZStack {
              Circle()
                .fill(.green)
                .frame(width: 15, height: 15)
              Text(event.title)
                .font(.caption)
                .foregroundColor(.black)
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
        RoundedRectangle(cornerRadius: 20)
          .stroke(.gray, lineWidth: 1)
      )

      Spacer()
    }
    .onAppear { loadData() }
  }

  private func loadData() {
    self.displayedLocations = []
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
