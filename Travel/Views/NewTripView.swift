//
//  NewTripView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

// View for creating a new trip with a name and date selection
struct NewTripView: View {
  @Binding var isPresented: Bool
  @State private var tripName: String = ""
  @State private var showDatePicker = false
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var tripRepository: TripRepository

  var body: some View {
    NavigationView {
      VStack {
        // Header
        HStack {
          Text("Create a new trip")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top)
            .padding(.leading, 20)
          Spacer()
        }

        // TextField for entering the trip name
        TextField("Trip name", text: $tripName)
          .padding()
          .frame(height: 50)
          .background(Color(.systemGray5))
          .cornerRadius(10)
          .padding(.horizontal, 20)
        
        // Next button
        HStack {
          Spacer()
          Button(action: {
            showDatePicker = true
          }) {
            Text("Next")
              .font(.headline)
              .frame(width: 100, height: 44)
              .background(Color("AccentColor"))
              .foregroundColor(.white)
              .cornerRadius(20)
              .padding(.vertical, 5)
          }
          .padding()
          .disabled(tripName.isEmpty)
        }
    
        Spacer()
      }
      .navigationBarItems(trailing: Button("Cancel") {
        isPresented = false
      })
      .sheet(isPresented: $showDatePicker) {
        DateSelectionView(
          tripName: tripName,
          onSave: { startDate, endDate in
            createNewTrip(startDate: startDate, endDate: endDate)
          },
          onCancel: {
            // Handle cancel action
            showDatePicker = false
            isPresented = false
          }
        )
        .presentationDetents([.fraction(0.97)])
        .presentationDragIndicator(.visible)
      }
    }
  }
  
  // Creates a new trip and saves it to the repositories
  private func createNewTrip(startDate: Date, endDate: Date) {
    let currUser = userRepository.users[0]
    let randomColor = getRandomColorName()
    let newTrip = Trip(
      id: UUID().uuidString,
      name: tripName,
      startDate: formatDate(date: startDate),
      endDate: formatDate(date: endDate),
      photo: "",
      color: randomColor,
      days: generateDays(from: startDate, to: endDate),
      travelers: [SimpleUser(id: currUser.id, name: currUser.name, photo: currUser.photo)]
    )

    // Add the trip to repositories
    tripRepository.trips.append(newTrip)
    tripRepository.addTrip(newTrip)
    userRepository.addTripToUser(currUser: currUser, newTripId: newTrip.id)
    
    // Dismiss the views
    showDatePicker = false
    isPresented = false
  }
  
  // Formats a Date object into a String
  private func formatDate(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(abbreviation: "ET")
    return formatter.string(from: date)
  }
  
  // Generates an array of Day` objects between the start and end dates
  private func generateDays(from start: Date, to end: Date) -> [Day] {
    var days: [Day] = []
    let calendar = Calendar.current
    var currentDate = calendar.startOfDay(for: start)
    while currentDate <= calendar.startOfDay(for: end) {
      let day = Day(id: UUID().uuidString, date: formatDate(date: currentDate), events: [])
      days.append(day)
      currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate.addingTimeInterval(24 * 60 * 60)
    }
    return days
  }
  
  // Selects a random color name for the trip
  private func getRandomColorName() -> String {
    let colors = ["yellow", "purple", "orange", "blue", "red", "green", "gray"]
    return colors.randomElement() ?? "gray"
  }
}
