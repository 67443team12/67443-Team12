//
//  NewTripView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct NewTripView: View {
  @State private var tripName: String = ""
  @State private var showDatePicker = false
	@EnvironmentObject var aliceVM: MockUser
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var tripRepository: TripRepository

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("Create a new trip")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
            .padding(.leading, 20)
          Spacer()
        }

        TextField("Trip name", text: $tripName)
          .padding()
          .frame(height: 50)
          .background(Color(.systemGray5))
          .cornerRadius(10)
          .padding(.horizontal, 20)
        
        HStack {
          Spacer()
          Button(action: {
            showDatePicker = true
          }) {
            Text("Next")
              .font(.headline)
              .frame(width: 100, height: 44)
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(20)
          }
          .padding()
          .disabled(tripName.isEmpty)
        }
    
        Spacer()
      }
      .navigationBarItems(trailing: Button("Cancel") {
        presentationMode.wrappedValue.dismiss()
      })
      .sheet(isPresented: $showDatePicker) {
        DateSelectionView(tripName: tripName, onSave: { startDate, endDate in
          // Create a new Trip object
          let newTrip = Trip(
            id: UUID().uuidString,
            name: tripName,
            startDate: formatDate(date: startDate),
            endDate: formatDate(date: endDate),
            photo: "", // Placeholder
            color: "red", // Placeholder color
            days: generateDays(from: startDate, to: endDate),
            travelers: [SimpleUser.alice]
          )
          
          // Save the new trip to the repository
          tripRepository.trips.append(newTrip)
          tripRepository.addTrip(newTrip)
					aliceVM.addTrip(tripID: newTrip.id)
          
          // Dismiss both the date picker and the new trip view
          showDatePicker = false
          presentationMode.wrappedValue.dismiss()
        })
        .presentationDetents([.fraction(0.97)])
        .presentationDragIndicator(.visible)
      }
    }
  }
  
  private func formatDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(abbreviation: "ET")
    return formatter.string(from: date)
  }
  
  private func generateDays(from start: Date, to end: Date) -> [Day] {
    var days: [Day] = []
    let calendar = Calendar.current
    var currentDate = calendar.startOfDay(for: start)

    while currentDate <= calendar.startOfDay(for: end) {
      let day = Day(id: UUID().uuidString, date: formatDate(date: currentDate), events: [])
      days.append(day)
      // Move to the next day
      currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate.addingTimeInterval(24 * 60 * 60)
    }

    return days
  }
}

struct NewTripView_Previews: PreviewProvider {
  static var previews: some View {
    NewTripView(tripRepository: TripRepository())
			.environmentObject(MockUser(user: User.example))
  }
}
