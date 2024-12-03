//
//  FriendProfileView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

struct FriendProfileView: View {
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var tripRepository = TripRepository()
  
  let user: User
  let currUser: User
  
  @State private var showAlert = false
  
  var sharedTrips: [Trip] {
    tripRepository.trips.filter { user.Trips.contains($0.id) && currUser.Trips.contains($0.id) }
  }
  
  @State private var isSharedTripsExpanded: Bool = true
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          AsyncImage(url: URL(string: user.photo)) { image in
            image.resizable()
          } placeholder: {
            Color.gray
          }
          .frame(width: 100, height: 100)
          .clipShape(Circle())
          .padding(.leading, 20)
          
          VStack(alignment: .leading) {
            Text(user.name)
              .font(.largeTitle)
              .fontWeight(.semibold)
            Text("ID: \(user.id)")
              .fontWeight(.semibold)
          }
          .padding(.leading, 20)
          Spacer()
        }
        
        List {
          Section(
            header: Button(action: {
              withAnimation {
                isSharedTripsExpanded.toggle()
              }
            }) {
              HStack {
                Text("Shared Trips")
                  .font(.headline)
                Spacer()
                Image(systemName: isSharedTripsExpanded ? "chevron.up" : "chevron.down")
                  .font(.caption)
                  .foregroundColor(.gray)
              }
              .padding(.vertical, 10) // Increased padding
              .contentShape(Rectangle()) // Make the entire area tappable
            }
          ) {
            if isSharedTripsExpanded {
              ForEach(sharedTrips, id: \.id) { trip in
                FriendProfileTripCardView(trip: trip, tripRepository: tripRepository)
                  .padding(.vertical, 5) // Add padding to trip rows
              }
            }
          }
        }
        .listStyle(PlainListStyle())
      }
    }
    .padding(.top)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          showAlert = true
        }) {
          VStack(spacing: 2) {
            Text("Delete")
              .fontWeight(.semibold)
              .foregroundColor(Color.red)
          }
        }
        .alert(isPresented: $showAlert) {
          Alert(
            title: Text("Delete Friend"),
            message: Text("Are you sure you want to delete this friend?"),
            primaryButton: .destructive(Text("Delete")) {
              userRepository.deleteFriend(currUser: currUser, friend: user)
            },
            secondaryButton: .cancel()
          )
        }
      }
    }
  }
}
