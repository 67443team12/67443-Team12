//
//  SplashView.swift
//  Travel
//
//  Created by Emma Shi on 11/21/24.
//

import SwiftUI

// Splash screen that transitions to the main ContentView after a brief delay
struct SplashView: View {
  @State var isActive: Bool = false
  
  var body: some View {
    ZStack {
      // Check if splash screen should transition to the main content
      if self.isActive {
        ContentView()
      } else {
        // Splash screen content
        Color("LightPurple")
          .ignoresSafeArea()
        Text("TogetherTrip")
          .font(Font.custom("Lobster", size: 48))
          .fontWeight(.bold)
      }
    }
    .onAppear {
      // Delay the transition to `ContentView` by 2.5 seconds
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        withAnimation {
          self.isActive = true
        }
      }
    }
  }
}

#Preview {
  SplashView()
}
