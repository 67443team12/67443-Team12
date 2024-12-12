//
//  FriendsListView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

// View for displaying a list of friends for the current user
struct FriendsListView: View {
  @ObservedObject var userRepository: UserRepository
  @State private var searchText: String = ""
  
  // Filters the friends of the current user based on the search text
  var filteredFriends: [User] {
    let currentUser = userRepository.users[0]
    let friendIDs = currentUser.Friends
    return userRepository.users.filter { friendIDs.contains($0.id) }
      .filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
  }
  
  var body: some View {
    NavigationView {
      VStack {
        // Header with title and "Add Friend" button
        HStack {
          Text("Friends")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)
          Spacer()
          NavigationLink(destination: AddFriendView(userRepository: userRepository)) {
            Image(systemName: "person.badge.plus")
              .font(.largeTitle)
              .padding(.top, 15)
              .padding(.trailing, 20)
          }
          // Red dot indicator for pending friend requests
          .overlay {
            if !userRepository.users[0].Requests.isEmpty {
              Image(systemName: "circle.fill")
                .foregroundColor(Color.red)
                .font(.caption2)
                .padding([.leading, .bottom])
            }
          }
        }
        
        // Search bar for filtering friends
        HStack {
          TextField("Search friend", text: $searchText)
            .padding(.leading, 10)
            .padding(.vertical, 15)
          if !searchText.isEmpty {
            Button(action: {
              searchText = ""
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
        
        // Friends list section
        ZStack {
          Color("Cream")
            .ignoresSafeArea()
          
          List {
            ForEach(filteredFriends, id: \.id) { friend in
              ZStack(alignment: .leading) {
                FriendsRowView(friend: friend)
                NavigationLink(destination: FriendProfileView(userRepository: userRepository, user: friend, currUser: userRepository.users[0])) {
                  EmptyView()
                }
                .opacity(0)
              }
            }
            .listRowBackground(Color("Cream"))
          }
          .listStyle(PlainListStyle())
          .background(Color.clear)
          .scrollContentBackground(.hidden)
        }
      }
      .background(Color("Cream"))
      .onAppear {
        userRepository.get()
      }
    }
  }
}
