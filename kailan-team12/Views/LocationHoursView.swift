//
//  LocationHoursView.swift
//  kailan-team12
//
//  Created by k mao on 11/5/24.
//

import SwiftUI

struct LocationHoursView: View {
  let location: Location
    var body: some View {
      VStack {
        Text("Open Hours")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
        Text("Sunday: \(location.sunday)")
        Text("Monday: \(location.monday)")
        Text("Tuesday: \(location.tuesday)")
        Text("Wednesday: \(location.wednesday)")
        Text("Thursday: \(location.thursday)")
        Text("Friday: \(location.friday)")
        Text("Saturday: \(location.saturday)")
        Spacer()
      }
    }
}

