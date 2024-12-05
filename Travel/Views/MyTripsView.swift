//
//  MyTripsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct MyTripsView: View {
//  @EnvironmentObject var aliceVM: MockUser
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var tripRepository = TripRepository()
  @ObservedObject var locationRepository = LocationRepository()
  @State private var showNewTripView = false
  
  // search stuff
  @State var searchText: String = ""
  @State var displayedTrips: [Trip] = [Trip]()
  
  var body: some View {
    let binding = Binding<String>(get: {
      self.searchText
    }, set: {
      self.searchText = $0
      self.tripRepository.search(searchText: self.searchText)
      self.displayTrips()
    })
    
    NavigationView {
      VStack {
        HStack {
          Text("My Trips")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)
          Spacer()
          Button(action: {
            showNewTripView = true
          }) {
            Image(systemName: "plus.circle")
              .font(.largeTitle)
              .padding(.trailing, 20)
              .padding(.top, 15)
          }
        }
        
        HStack {
          TextField("Search trip", text: binding)
            .padding(.leading, 10) // Extra padding for text
            .padding(.vertical, 15)
          
          
          if !searchText.isEmpty {
            Button(action: {
              searchText = ""
              displayTrips() // Update displayedLocations after clearing
            }) {
              Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
            }
            .padding(.trailing, 10)
          }
        }
        .background(Color("LightPurple"))
        .cornerRadius(15)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        
        if !searchText.isEmpty {
          ScrollView {
            ForEach(displayedTrips.filter { userRepository.users[0].Trips.contains($0.id) }.sorted { $0 > $1 }) { trip in
              NavigationLink(destination: TripDetailsView(trip: trip, tripRepository: tripRepository, locationRepository: locationRepository, userRepository: userRepository)
              ) {
                TripCardView(trip: trip, tripRepository: tripRepository)
                  .padding(.bottom, 10)
                  .padding(.top, 10)
              }
            }
          }
          .padding(.horizontal)
        } else {
          ScrollView {
            ForEach(tripRepository.trips.filter { userRepository.users[0].Trips.contains($0.id) }.sorted { $0 > $1 }) { trip in
       NavigationLink(destination: TripDetailsView(trip: trip, tripRepository: tripRepository, locationRepository: locationRepository, userRepository: userRepository)
              ) {
                TripCardView(trip: trip, tripRepository: tripRepository)
                  .padding(.bottom, 10)
                  .padding(.top, 10)
              }
            }
          }
        }
      }
      .navigationBarHidden(true)
      .background(Color("Cream"))
      .sheet(isPresented: $showNewTripView) {
        NewTripView(isPresented: $showNewTripView, userRepository: userRepository, tripRepository: tripRepository)
          .presentationDetents([.fraction(0.97)])
          .presentationDragIndicator(.visible)
//          .environmentObject(aliceVM)
      }
      .onAppear {
        tripRepository.get()
        self.displayTrips() // Initialize displayedTrips with all trips
      }
    }
  }
  
  private func displayTrips() {
    if searchText == "" {
      displayedTrips = tripRepository.trips
      tripRepository.filteredTrips = []
    } else {
      displayedTrips = tripRepository.filteredTrips
    }
  }
}

//struct MyTripsView_Previews: PreviewProvider {
//  static var previews: some View {
//    MyTripsView()
//  }
//}
