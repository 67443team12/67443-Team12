//
//  TripCardView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

// View for displaying a card for an individual trip
struct TripCardView: View {
  @State var trip: Trip
  @ObservedObject var tripRepository: TripRepository
  @State private var selectedItems: [PhotosPickerItem] = []
  @State private var photoURL: URL? = nil
  @State private var isShowingPicker = false
  
  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .bottomTrailing) {
        // Display trip image or fallback to gradient based on trip's color
        AsyncImage(url: URL(string: trip.photo)) { image in
          image.resizable()
        } placeholder: {
          getGradient(from: trip.color)
        }
        .frame(height: 150)
        .clipShape(
          .rect(
            topLeadingRadius: 15,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 0,
            topTrailingRadius: 15
          )
        )

        // Photo picker button to update the trip's image
        Button(action: {
          isShowingPicker = true
        }) {
          Image(systemName: "photo.on.rectangle.angled")
            .font(.title2)
            .foregroundColor(.white)
            .padding(10)
            .shadow(color: .black, radius: 2)
        }
        .photosPicker(isPresented: $isShowingPicker, selection: $selectedItems, maxSelectionCount: 1, matching: .images)
        .onChange(of: selectedItems) { newItems in
          guard let selectedItem = newItems.first else { return }
          Task {
            // Upload selected photo to Firebase Storage
            if let selectedAsset = try? await selectedItem.loadTransferable(type: Data.self) {
              tripRepository.uploadPhotoToStorage(imageData: selectedAsset, tripId: trip.id) { photoURL in
                if let photoURL = photoURL {
                  print("Photo uploaded and URL updated: \(photoURL)")
                  trip.photo = photoURL
                }
              }
            }
          }
        }
      }

      // Display trip name
      Text(trip.name)
        .font(.title3.bold())
        .padding([.leading])
        .padding(.top, 6)
        .foregroundColor(.black)

      // Display trip start and end dates
      Text("\(trip.formattedStartDate) - \(trip.formattedEndDate)")
        .font(.subheadline)
        .foregroundColor(.gray)
        .padding([.leading, .bottom])
    }
    .background(Color.white)
    .cornerRadius(15)
    .shadow(radius: 5)
    .padding(.horizontal, 20)
  }
  
  // Converts a color name to a SwiftUI Color
  func getColor(from colorName: String) -> Color {
    switch colorName.lowercased() {
    case "blue": return Color.blue
    case "red": return Color.red
    case "green": return Color.green
    case "yellow": return Color.yellow
    case "purple": return Color.purple
    case "orange": return Color.orange
    case "gray": return Color.gray
    default: return Color.gray
    }
  }
  
  // Creates a gradient using the given color name
  func getGradient(from colorName: String) -> LinearGradient {
    let color = getColor(from: colorName)
    let lighterColor = color.opacity(0.4)
    return LinearGradient(
      gradient: Gradient(colors: [lighterColor, color]),
      startPoint: .top,
      endPoint: .bottom
    )
  }
}
