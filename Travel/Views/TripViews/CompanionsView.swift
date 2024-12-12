//
//  CompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

// View for displaying companions for a specific trip
struct CompanionsView: View {
  var trip: Trip
  @ObservedObject var tripRepository: TripRepository
  @ObservedObject var userRepository: UserRepository
  @State private var showAlert = false
  @Environment(\.presentationMode) var presentationMode
  
  init(trip: Trip, tripRepository: TripRepository, userRepository: UserRepository) {
    self.trip = trip
    self.tripRepository = tripRepository
    self.userRepository = userRepository
  }
  
  var body: some View {
    VStack {
      // List of current companions (excluding the current user)
      VStack {
        ForEach(tripRepository.getCompanions(tripId: trip.id)) { person in
          if person.id != userRepository.users[0].id { // Exclude current user
            CompanionRowView(
              person: person,
              trip: trip,
              tripRepository: tripRepository,
              userRepository: userRepository
            )
          }
        }
      }
      .padding(.vertical)
      
      // Navigation link to invite more companions
      NavigationLink(destination: AddCompanionsView(trip: trip, tripRepository: tripRepository, userRepository: userRepository)) {
        ZStack {
          Rectangle()
            .fill(Color("LightPurple"))
            .frame(height: 70)
          HStack {
            Text("Invite More Friends")
              .padding(.leading, 30)
              .fontWeight(.semibold)
            Spacer()
            Image(systemName: "arrow.right")
              .fontWeight(.semibold)
              .padding(.trailing, 30)
          }
          .foregroundColor(.black)
        }
      }
      
      Spacer()
      
      // Button to leave the trip
      Button(action: {
        showAlert = true
      }) {
        ZStack {
          Rectangle()
            .fill(Color("LightPurple"))
            .frame(height: 70)
          Text("Leave Trip")
            .foregroundColor(.red)
            .fontWeight(.bold)
        }
      }
      .alert(isPresented: $showAlert) {
        Alert(
          title: Text("Confirm Leaving This Trip"),
          message: Text("This trip will still be available to other companions after you leave."),
          primaryButton: .destructive(Text("Leave")) {
            leaveTrip()
          },
          secondaryButton: .cancel()
        )
      }
    }
    .navigationTitle("Companions")
    .navigationBarTitleDisplayMode(.inline)
    .background(Color("Cream"))
  }
  
  // Handles the action of leaving the trip for the current user
  func leaveTrip() {
    let currUser = userRepository.users[0]
    tripRepository.removeTraveler(
      trip: trip,
      traveler: SimpleUser(id: currUser.id, name: currUser.name, photo: currUser.photo)
    )
    userRepository.leaveTrip(tripId: trip.id, userId: currUser.id)
    presentationMode.wrappedValue.dismiss()
  }
}
