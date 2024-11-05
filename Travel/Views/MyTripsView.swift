//
//  MyTripsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct MyTripsView: View {
	@ObservedObject var tripListViewModel = TripListViewModel()
//  @ObservedObject var tripRepository = TripRepository()
  @State private var showNewTripView = false

  var body: some View {
		let tripViewModels = tripListViewModel.tripViewModels.sorted(by: {$0.trip > $1.trip})
		
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
					ForEach(tripViewModels) { tVM in
						NavigationLink(destination: TripDetailsView(trip: tVM.trip)) {
							TripCardView(trip: tVM.trip)
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
    }
  }
}

struct MyTripsView_Previews: PreviewProvider {
  static var previews: some View {
    MyTripsView()
  }
}
