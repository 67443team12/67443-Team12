//
//  LocationHoursView.swift
//  Travel
//
//  Created by Kailan Mao on 11/5/24.
//

import SwiftUI

// View for displaying the opening hours of a specific location
struct LocationHoursView: View {
  let location: Location
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    VStack {
      // Back button and title
      HStack {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          HStack {
            Image(systemName: "chevron.left")
              .font(.title3)
              .fontWeight(.medium)
            Text("Back")
              .font(.title3)
              .fontWeight(.medium)
          }
          .foregroundColor(.accentColor)
        }
        Spacer()
      }
      .padding([.leading, .top], 20)
      .padding(.bottom, 2)

      // Title for the page
      Text("Open Hours")
        .font(.title)
        .fontWeight(.bold)
        .padding(.bottom, 8)

      // Display hours for each day of the week
      VStack(spacing: 6) {
        Text("Monday: ").fontWeight(.bold) + Text(location.monday)
        Text("Tuesday: ").fontWeight(.bold) + Text(location.tuesday)
        Text("Wednesday: ").fontWeight(.bold) + Text(location.wednesday)
        Text("Thursday: ").fontWeight(.bold) + Text(location.thursday)
        Text("Friday: ").fontWeight(.bold) + Text(location.friday)
        Text("Saturday: ").fontWeight(.bold) + Text(location.saturday)
        Text("Sunday: ").fontWeight(.bold) + Text(location.sunday)
      }
      .multilineTextAlignment(.center)
      .padding(.horizontal, 20)

      Spacer()
    }
    .navigationBarBackButtonHidden(true)
  }
}
