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
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack(alignment: .leading) {
      // Back button and title
      HStack(alignment: .center) {
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
      .padding(.bottom, 20)
      
      // Location details section
      VStack(alignment: .leading, spacing: 15) {
        HStack {
          Text(location.name)
            .font(.title)
            .fontWeight(.bold)
            .padding(.leading, 20)
          Spacer()
          NavigationLink(destination: AddEventView(location: location, trip: trip, dayNumber: dayNumber, tripRepository: tripRepository)) {
            Image(systemName: "plus.circle")
              .foregroundColor(.accentColor)
              .font(.largeTitle)
          }
          .padding(.trailing, 20)
        }

        // Address
        HStack {
          Image(systemName: "map")
            .foregroundColor(.gray)
          Text(location.address)
        }
        .font(.body)
        .padding(.leading, 20)
        
        // Rating
        HStack {
          Image(systemName: "star.fill")
            .foregroundColor(.yellow)
          Text(String(format: "%.1f", location.ratings))
          Spacer()
        }
        .padding(.leading, 20)
        
        // Duration
        HStack {
          Image(systemName: "clock")
            .foregroundColor(.gray)
          Text("Duration: \(location.duration)")
          Spacer()
        }
        .padding(.leading, 20)
        
        // See Hours link
        HStack {
          Image(systemName: "clock")
            .foregroundColor(.gray)
          NavigationLink(destination: LocationHoursView(location: location)) {
            Text("See Hours")
              .foregroundColor(.accentColor)
              .underline()
              .fontWeight(.bold)
          }
          Spacer()
        }
        .padding(.leading, 20)
        
        Spacer()
      }
      .padding(.top, 10)
    }
    .navigationBarBackButtonHidden(true)
  }
}
