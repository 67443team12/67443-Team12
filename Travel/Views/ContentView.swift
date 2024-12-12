//
//  ContentView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var tripRepository = TripRepository()
  @ObservedObject var postRepository = PostRepository()
  
  init() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBackground
    UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
  var body: some View {
    if userRepository.users.isEmpty {
      // Loading state for users
      Text("Loading users...")
    } else {
      TabView {
        // Trips tab
        MyTripsView(userRepository: userRepository)
          .tabItem {
            Label("Trips", systemImage: "calendar")
          }
        
        // Posts tab
        PostsView(userRepository: userRepository, postRepository: postRepository)
          .tabItem {
            Label("Posts", systemImage: "square.and.pencil")
          }
        
        // Friends tab
        FriendsListView(userRepository: userRepository)
          .tabItem {
            Label("Friends", systemImage: "person.2")
          }
        
        // Me tab
        MeView(userRepository: userRepository, postRepository: postRepository)
          .tabItem {
            Label("Me", systemImage: "person.circle")
          }
      }
    }
  }
}

#Preview {
  ContentView()
}
