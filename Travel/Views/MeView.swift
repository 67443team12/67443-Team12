//
//  MeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

// View for displaying the user's profile information
struct MeView: View {
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var postRepository: PostRepository
  
  var body: some View {
    NavigationView {
      VStack(spacing: 40) {
        // Header with title and edit button
        HStack {
          Text("Me")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)
          Spacer()
          // edit profile action
          NavigationLink(destination: EditMeView(userRepository: userRepository, id: userRepository.users[0].id, newName: userRepository.users[0].name, newImage: userRepository.users[0].photo)) {
            VStack {
              Image(systemName: "pencil.and.scribble")
                .font(.title)
              Text("Edit")
                .font(.caption)
            }
            .padding(.top, 15)
            .padding(.trailing, 20)
          }
        }
        
        // User profile section with image and details
        HStack {
          AsyncImage(url: URL(string: userRepository.users[0].photo)) { image in
            image.resizable()
          } placeholder: {
            Color.gray
          }
          .frame(width: 100, height: 100)
          .clipShape(Circle())
          .padding(.leading, 20)
          
          VStack(alignment: .leading) {
            Text(userRepository.users[0].name)
              .font(.largeTitle)
              .fontWeight(.semibold)
            Text("ID: \(userRepository.users[0].id)")
              .fontWeight(.semibold)
          }
          .padding(.leading, 20)
          Spacer()
        }
        
        // List of navigation links
        List {
          NavigationLink(
            destination: MyPostsView(postRepository: postRepository, userRepository: userRepository),
            label: {
              Text("My Posts")
                .padding(.vertical, 10)
            })
          .listRowBackground(Color("Cream"))
          
          NavigationLink(
            destination: MyBookmarksView(postRepository: postRepository, userRepository: userRepository),
            label: {
              Text("Bookmarks")
                .padding(.vertical, 10)
            })
          .listRowBackground(Color("Cream"))
        }
        .listStyle(PlainListStyle())
        .scrollDisabled(true)
      }
      .background(Color("Cream"))
      .onAppear {
        userRepository.get()
      }
    }
  }
}
