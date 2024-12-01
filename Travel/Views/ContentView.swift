//
//  ContentView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct ContentView: View {
  var aliceVM = MockUser(user: User.example)
  
  init() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.systemBackground
    UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
  var body: some View {
    TabView {
      MyTripsView()
        .tabItem {
          Label("Trips", systemImage: "calendar")
        }

      PostsView()
        .tabItem {
          Label("Posts", systemImage: "square.and.pencil")
      }

      Text("Friends View") // Placeholder for the Friends view
        .tabItem {
          Label("Friends", systemImage: "person.2")
        }

      MeView()
        .tabItem {
          Label("Me", systemImage: "person.circle")
        }
    }
    .environmentObject(aliceVM)
  }
}

#Preview {
  ContentView()
}
