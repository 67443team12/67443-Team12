//
//  AddFriendView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

// View for searching for new friends and viewing incoming friend requests
struct AddFriendView: View {
  @ObservedObject var userRepository: UserRepository
  @State private var searchText: String = ""
  @State private var showAlert = false
  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack(spacing: 15) {
      // Header with custom back button and title
      HStack {
        Button(action: {
          dismiss()
        }) {
          Image(systemName: "chevron.left")
            .font(.title2.bold())
            .foregroundColor(.accentColor)
        }
        Spacer()
        Text("Add Friend")
          .font(.title2)
          .fontWeight(.bold)
        Spacer()
      }
      .padding(.horizontal, 10)
      .padding(.top, 10)
      
      // Search bar
      HStack {
        TextField("Search account id", text: $searchText)
          .padding(.leading, 10)
          .padding(.vertical, 15)
          .onChange(of: searchText) { newValue in
            userRepository.searchById(searchText: newValue)
          }
        
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
      .padding(.vertical, 10)
      
      if searchText.isEmpty {
        // Display incoming friend requests
        VStack(spacing: 15) {
          Text("New Friend Requests")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
          
          ForEach(userRepository.users.filter { userRepository.users[0].Requests.contains($0.id) }) { request in
            RequestRowView(userRepository: userRepository, request: request, showAlert: $showAlert)
          }
          
          Spacer()
        }
      } else {
        // Display search results
        List {
          ForEach(userRepository.filteredUsers) { user in
            NavigationLink(destination: AddFriendDetailView(user: user, userRepository: userRepository)) {
              HStack(spacing: 20) {
                AsyncImage(url: URL(string: user.photo)) { image in
                  image.resizable()
                } placeholder: {
                  Color.gray
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                VStack(alignment: .leading) {
                  Text(user.name)
                    .fontWeight(.semibold)
                  Text("ID: \(user.id)")
                    .font(.subheadline)
                }
                Spacer()
              }
            }
          }
          .listRowBackground(Color("Cream"))
        }
        .listStyle(PlainListStyle())
      }
    }
    .navigationBarHidden(true)
    .background(Color("Cream"))
  }
}
