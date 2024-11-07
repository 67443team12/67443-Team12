//
//  DateSelectionView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI

struct DateSelectionView: View {
  let tripName: String
  @State private var startDate = Date()
  @State private var endDate = Date()
  @State private var showStartDatePicker = false
  @State private var showEndDatePicker = false
  @Environment(\.presentationMode) var presentationMode
  
  var onSave: ((Date, Date) -> Void)?
  var onCancel: (() -> Void)? // Closure for handling cancel action

  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("When will you go?")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top)
            .padding(.leading, 20)
          Spacer()
        }
        .padding(.bottom)

        VStack(alignment: .leading) {
          Text("Start Date")
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.leading, 20)
          
          Button(action: {
            showStartDatePicker.toggle()
            showEndDatePicker = false
          }) {
            Text(startDate, style: .date)
              .frame(maxWidth: .infinity, minHeight: 44)
              .background(Color(.systemGray5))
              .cornerRadius(10)
              .padding(.horizontal, 20)
              .foregroundColor(.primary)
          }
          .padding(.bottom)
          
          if showStartDatePicker {
            DatePicker("Select Start Date", selection: $startDate, displayedComponents: .date)
              .datePickerStyle(GraphicalDatePickerStyle())
              .padding(.horizontal, 20)
          }
          
          Text("End Date")
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.leading, 20)
          
          Button(action: {
            showEndDatePicker.toggle()
            showStartDatePicker = false
          }) {
            Text(endDate, style: .date)
              .frame(maxWidth: .infinity, minHeight: 44)
              .background(Color(.systemGray5))
              .cornerRadius(10)
              .padding(.horizontal, 20)
              .foregroundColor(.primary)
          }
          .padding(.bottom)
          
          if showEndDatePicker {
            DatePicker("Select End Date", selection: $endDate, displayedComponents: .date)
              .datePickerStyle(GraphicalDatePickerStyle())
              .padding(.horizontal, 20)
          }
        }
        
        Spacer().frame(height: 20)

        HStack {
          Spacer().frame(width: 60)
          Button(action: {
            presentationMode.wrappedValue.dismiss() // Goes back to NewTripView
          }) {
            Text("Back")
              .font(.headline)
              .frame(width: 100, height: 44)
              .background(Color("LightPurple"))
              .foregroundColor(Color("AccentColor"))
              .cornerRadius(20)
          }
          Spacer()
          Button(action: {
            onSave?(startDate, endDate)
            presentationMode.wrappedValue.dismiss()
          }) {
            Text("Done")
              .font(.headline)
              .frame(width: 100, height: 44)
              .background(Color("AccentColor"))
              .foregroundColor(.white)
              .cornerRadius(20)
          }
          Spacer().frame(width: 60)
        }
        
        Spacer()
      }
      .navigationBarItems(trailing: Button("Cancel") {
        onCancel?() // Trigger the cancel action to go back to MyTripsView
      })
      .presentationDetents([.fraction(0.9)])
      .presentationDragIndicator(.visible)
    }
  }
}

struct DateSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    DateSelectionView(tripName: "Sample Trip")
  }
}
