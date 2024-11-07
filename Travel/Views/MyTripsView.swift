//
//  MyTripsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct MyTripsView: View {
	@EnvironmentObject var aliceVM: MockUser
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
					ForEach(tripRepository.trips.filter { aliceVM.user.Trips.contains($0.id) }) { trip in
						NavigationLink(destination: TripDetailsView(trip: trip, tripRepository: tripRepository)
							.environmentObject(aliceVM)
						) {
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
        NewTripView(tripRepository: tripRepository)
          .presentationDetents([.fraction(0.97)])
          .presentationDragIndicator(.visible)
					.environmentObject(aliceVM)
      }
      .onAppear {
        tripRepository.get()
      }
    }
  }
}

struct MyTripsView_Previews: PreviewProvider {
  static var previews: some View {
		MyTripsView().environmentObject(MockUser(user: User.example))
  }
}
