//
//  LocationDetailView.swift
//  kailan-team12
//
//  Created by Kailan Mao on 11/5/24.
//

import Foundation
import SwiftUI

struct LocationDetailView: View {
  let location: Location
  let trip: Trip
  let dayNumber: Int
  let tripRepository: TripRepository
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        HStack {
          Text(location.name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.horizontal)
          NavigationLink(destination: AddEventView(location: location, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)) {
            Image(systemName: "plus")
              .font(.title2)
              .foregroundColor(.blue)
          }
        }
        
        HStack {
          Image(systemName: "star.fill")
            .foregroundColor(.yellow)
          Text(String(format: "%.1f", location.ratings))
          Spacer()
        }
        .padding(.leading, 20)
        .padding(.top, 10)

        HStack {
          Image(systemName: "clock")
            .foregroundColor(.gray)
          Text("Duration: \(location.duration)")
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(.leading, 20)
        .padding(.top, 10)

        HStack {
          Image(systemName: "clock")
            .foregroundColor(.gray)
          NavigationLink(destination: LocationHoursView(location: location)) {
            Text("See Hours")
              .font(.caption)
              .foregroundColor(.blue)
              .underline()
          }
        }
        .padding(.leading, 20)
        .padding(.top, 10)

        Spacer()
      }
    }
  }
}
