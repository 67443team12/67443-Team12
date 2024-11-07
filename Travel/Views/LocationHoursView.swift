//
//  LocationHoursView.swift
//  kailan-team12
//
//  Created by Kailan Mao on 11/5/24.
//

import SwiftUI

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
      .padding(.bottom, 5)

      // Title
      Text("Open Hours")
        .font(.title)
        .fontWeight(.bold)
        .padding(.bottom, 10)

      // Hours for each day, centered
      VStack(spacing: 6) {
        Text("Monday: \(location.monday)")
        Text("Tuesday: \(location.tuesday)")
        Text("Wednesday: \(location.wednesday)")
        Text("Thursday: \(location.thursday)")
        Text("Friday: \(location.friday)")
        Text("Saturday: \(location.saturday)")
        Text("Sunday: \(location.sunday)")
      }
      .multilineTextAlignment(.center) // Center-align text
      .padding(.horizontal, 20)

      Spacer()
    }
    .navigationBarBackButtonHidden(true)
  }
}
