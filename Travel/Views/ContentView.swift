//
//  ContentView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      TabView {
        MyTripsView()
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

        MeView()
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
