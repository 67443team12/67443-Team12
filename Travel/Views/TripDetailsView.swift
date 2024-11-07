//
//  TripDetailsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripDetailsView: View {
  var trip: Trip
  var tripRepository: TripRepository
  @State private var selectedIndex = 0
  @ObservedObject var locationRepository = LocationRepository()
	
	@EnvironmentObject var aliceVM: MockUser

  var body: some View {
    VStack {
      HStack {
        Text(trip.name)
          .font(.largeTitle)
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .center)
      }
      .overlay(
				NavigationLink(destination: CompanionsView(people: trip.travelers, trip: trip, tripRepository: tripRepository).environmentObject(aliceVM)) {
          Image(systemName: "person.3")
            .font(.title)
            .fontWeight(.bold)
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
      )
      
      if !trip.days.isEmpty {
        HStack {
          Button(action: {
            if selectedIndex > 0 {
              selectedIndex -= 1
            }
          }) {
            Image(systemName: "arrow.backward")
          }
          .disabled(selectedIndex == 0)
          
          Spacer()
          
          Text("Day \(selectedIndex + 1): \(trip.days[selectedIndex].date)")
            .font(.headline)
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(10)
          
          Spacer()
          
          Button(action: {
            if selectedIndex < trip.days.count - 1 {
              selectedIndex += 1
            }
          }) {
            Image(systemName: "arrow.forward")
          }
          .disabled(selectedIndex == trip.days.count - 1)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        
        ScrollView {
          DayView(trip: trip, day: trip.days[selectedIndex], dayNumber: selectedIndex + 1, locationRepository: locationRepository, tripRepository: tripRepository)
        }
      } else {
        Text("Loading days...")
          .font(.subheadline)
          .foregroundColor(.gray)
          .padding()
      }
    }
//    .toolbar(.hidden, for: .tabBar)
  }
}

struct TripDetailsView_Previews: PreviewProvider {
  static var previews: some View {
		TripDetailsView(trip: Trip.example, tripRepository: TripRepository()).environmentObject(MockUser(user: User.example))
  }
}
