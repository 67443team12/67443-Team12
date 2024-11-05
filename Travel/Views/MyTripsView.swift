//
//  MyTripsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct MyTripsView: View {
  @ObservedObject var tripRepository = TripRepository()
  @State private var showNewTripView = false

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("My Trips")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)
          Spacer()
          Button(action: {
            showNewTripView = true
          }) {
            Image(systemName: "plus.circle")
              .font(.largeTitle)
              .padding(.trailing, 20)
              .padding(.top, 10)
          }
        }
        
        ScrollView {
          ForEach(tripRepository.trips) { trip in
            NavigationLink(destination: TripDetailsView(trip: trip)) {
              TripCardView(trip: trip)
                .padding(.bottom, 10)
                .padding(.top, 10)
            }
          }
        }
        .padding(.horizontal)
      }
      .navigationBarHidden(true)
      .sheet(isPresented: $showNewTripView) {
        NewTripView()
          .presentationDetents([.fraction(0.97)])
          .presentationDragIndicator(.visible)
      }
      .onAppear {
        tripRepository.get()
      }
    }
  }
}

struct MyTripsView_Previews: PreviewProvider {
  static var previews: some View {
    MyTripsView()
  }
}
