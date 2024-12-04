//
//  CompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct CompanionsView: View {
//  var people: [SimpleUser]
  var trip: Trip
  
  @ObservedObject var tripRepository: TripRepository
  @ObservedObject var userRepository: UserRepository
  
  @State private var showAlert = false
  
//  @EnvironmentObject var aliceVM: MockUser
  @Environment(\.presentationMode) var presentationMode
  
  init(trip: Trip, tripRepository: TripRepository, userRepository: UserRepository) {
    self.trip = trip
    self.tripRepository = tripRepository
    self.userRepository = userRepository
  }
  
  var body: some View {
    VStack {
      VStack {
        ForEach(tripRepository.getCompanions(tripId: trip.id)) { person in
          //  not showing current user in the list
          if person.id != userRepository.users[0].id {
            CompanionRowView(person: person, trip: trip, tripRepository: tripRepository, userRepository: userRepository)
          }
        }
      }
      .padding(.vertical)
      
      NavigationLink(destination: AddCompanionsView(trip: trip, tripRepository: tripRepository, userRepository: userRepository)) {
        ZStack {
          Rectangle()
            .fill(Color("LightPurple"))
            .frame(height: 70)
          HStack() {
            Text("Invite More Friends")
              .padding(.leading, 30)
              .fontWeight(.semibold)
            Spacer()
            Image(systemName: "arrow.right")
              .fontWeight(.semibold)
              .padding(.trailing, 30)
          }
          .foregroundStyle(.black)
        }
      }
      
      Spacer()
      
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
      }.alert(isPresented: $showAlert) {
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
  
//  func refreshCompanions(newCompanions: [SimpleUser]) {
//    // Update the companions list after friends are added
//    companions = newCompanions
//  }
  
  func leaveTrip() {
    var currUser = userRepository.users[0]
    tripRepository.removeTraveler(trip: trip, traveler: SimpleUser(id: currUser.id, name: currUser.name, photo: currUser.photo))
    userRepository.leaveTrip(tripId: trip.id, userId: currUser.id)
    presentationMode.wrappedValue.dismiss()
  }
  
}


