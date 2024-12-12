//
//  FriendProfileView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

// View for displaying a friend's profile
struct FriendProfileView: View {
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var tripRepository = TripRepository()
  let user: User
  let currUser: User
  @State private var showAlert = false
  @State private var isSharedTripsExpanded: Bool = true
  
  // Calculates shared trips between the current user and the displayed friend
  var sharedTrips: [Trip] {
    tripRepository.trips.filter { user.Trips.contains($0.id) && currUser.Trips.contains($0.id) }
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        Color("Cream")
          .ignoresSafeArea()
        
        VStack {
          // Header with friend's profile picture and details
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
          
          // List showing shared trips
          List {
            Section(
              header: Button(action: {
                // Toggle shared trips section visibility with animation
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
                .padding(.vertical, 10)
                .contentShape(Rectangle())
              }
            ) {
              // Show shared trips if expanded
              if isSharedTripsExpanded {
                ForEach(sharedTrips, id: \.id) { trip in
                  FriendProfileTripCardView(trip: trip, tripRepository: tripRepository)
                    .padding(.vertical, 5)
                }
                .listRowBackground(Color("Cream"))
              }
            }
          }
          .listStyle(PlainListStyle())
          .scrollContentBackground(.hidden)
          .background(Color("Cream"))
        }
        .padding(.top)
      }
    }
    .toolbar {
      // Toolbar button for deleting the friend
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
