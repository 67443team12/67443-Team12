//
//  ContentView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct ContentView: View {
//  var aliceVM = MockUser(user: User.example)
  @ObservedObject var userRepository = UserRepository()
  
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
        Text("Loading users...")
    } else {
      
      TabView {
        MyTripsView(currUser: userRepository.users[0])
          .tabItem {
            Label("Trips", systemImage: "calendar")
          }

        Text("Posts View") // Placeholder for the Posts view
          .tabItem {
            Label("Posts", systemImage: "square.and.pencil")
          }

        Text("Friends View") // Placeholder for the Friends view
          .tabItem {
            Label("Friends", systemImage: "person.2")
          }

        MeView(userRepository: userRepository)
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
