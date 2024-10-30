//
//  TripCardView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct TripCardView: View {
  var trip: Trip

  var body: some View {
    VStack(alignment: .leading) {
      // Display color block
      getColor(from: trip.color)
        .frame(height: 150)
        .cornerRadius(10)

      // Display trip name and dates
      Text(trip.tripName)
        .font(.headline)
        .padding([.top, .leading])
        .foregroundColor(.black)
      
      Text("\(trip.startDate) - \(trip.endDate)")
        .font(.subheadline)
        .foregroundColor(.gray)
        .padding([.leading, .bottom])
    }
    .background(Color.white)
    .cornerRadius(15)
    .shadow(radius: 5)
    .padding(.horizontal)
  }
  
  func getColor(from colorName: String) -> Color {
    switch colorName.lowercased() {
    case "blue": return Color.blue
    case "red": return Color.red
    case "green": return Color.green
    case "yellow": return Color.yellow
    case "purple": return Color.purple
    case "orange": return Color.orange
    case "gray": return Color.gray
    default: return Color.gray // Fallback color
    }
  }
}

struct TripCardView_Previews: PreviewProvider {
  static var previews: some View {
    TripCardView(trip: Trip(
      id: "1",
      tripName: "Miami",
      startDate: "2024-03-05",
      endDate: "2024-03-08",
      photo: "",
      color: "blue"
    ))
    .previewLayout(.sizeThatFits)
  }
}
