//
//  AddCompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/7/24.
//

import SwiftUI

// View for adding companions to a trip
struct AddCompanionsView: View {
  var trip: Trip
  @ObservedObject var tripRepository: TripRepository
  @ObservedObject var userRepository: UserRepository
  @Environment(\.presentationMode) var presentationMode
  @State private var selectedFriends: [User] = []

  // Only show those who are friends of the user and not already in the trip
  var availableFriends: [User] {
    userRepository.users.filter { user in
      userRepository.users[0].Friends.contains(user.id) &&
      !trip.travelers.map { $0.id }.contains(user.id)
    }
  }
  
  var body: some View {
    VStack {
      // List available friends to add as companions
      List(availableFriends) { friend in
        HStack(spacing: 20) {
          // Load friend profile photo
					AsyncImage(url: URL(string: friend.photo)) { image in
						image.resizable()
					} placeholder: {
						Circle()
							.fill(Color.gray)
					}
					.frame(width: 50, height: 50)
					.clipShape(Circle())
          
          Text(friend.name)
          
          Spacer()
          
          // Show a checkmark if the friend is selected
          if selectedFriends.contains(where: { $0.id == friend.id }) {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(.green)
          } else {
            Image(systemName: "circle")
              .foregroundColor(.gray)
          }
        }
        .contentShape(Rectangle())
        .onTapGesture {
          toggleSelection(friend)
        }
        .listRowBackground(Color("Cream"))
      }
      .listStyle(PlainListStyle())
      .background(Color("Cream"))
      
      // Save button appears only after choosing someone
      if !selectedFriends.isEmpty {
        Button(action: saveCompanions) {
          ZStack {
            Rectangle()
              .fill(Color("AccentColor"))
              .frame(height: 70)
              .cornerRadius(10)
            Text("Add Companions")
              .foregroundColor(.white)
              .fontWeight(.bold)
          }
          .padding(.horizontal)
        }
      }
    }
    .background(Color("Cream").ignoresSafeArea())
    .navigationTitle("Add Companions")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // Toggles selection of a friend
  private func toggleSelection(_ friend: User) {
    if let index = selectedFriends.firstIndex(where: { $0.id == friend.id }) {
      selectedFriends.remove(at: index)
    } else {
      selectedFriends.append(friend)
    }
  }
  
  // Saves selected companions to the trip and updates repositories
  private func saveCompanions() {
    tripRepository.addTravelers(trip: trip, travelers: selectedFriends)
    for friend in selectedFriends {
      userRepository.addTripToUser(currUser: friend, newTripId: trip.id)
    }
    let newTravelers = selectedFriends.map { user in
      SimpleUser(id: user.id, name: user.name, photo: user.photo)
    }
    selectedFriends.removeAll()
    presentationMode.wrappedValue.dismiss()
  }
}
