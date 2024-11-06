//
//  LocationDetailView.swift
//  kailan-team12
//
//  Created by k mao on 11/5/24.
//

import Foundation
import SwiftUI

struct LocationDetailView: View {
  let location: Location
  let trip: Trip
//  let tripRepository: TripRepository
//  let dayIndex: Int
  
  var body: some View {
    NavigationStack {
    VStack(alignment: .leading) {
      Text(location.name)
                      .font(.largeTitle)
                      .fontWeight(.bold)
                      .padding(.horizontal)
      HStack {
        Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
        Text(String(format: "%.1f", location.ratings))
        Spacer()
        NavigationLink(destination: AddEventView(location: location, trip: trip)) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
      }
      
      HStack {
          Image(systemName: "clock")
              .foregroundColor(.gray)
        Text("Duration: \(location.duration)")
              .font(.caption)
              .foregroundColor(.gray)
      }
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
      Spacer()
      
    }
  }
  }
  
}
