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

struct TripCardView: View {
	@State var trip: Trip
	@ObservedObject var tripRepository: TripRepository
	@State private var selectedItems: [PhotosPickerItem] = []
	@State private var photoURL: URL? = nil
	@State private var isShowingPicker = false
	
	var body: some View {
		VStack(alignment: .leading) {
			ZStack(alignment: .bottomTrailing) {
				// Display image or color gradient
				AsyncImage(url: URL(string: trip.photo)) { image in
					image.resizable()
				} placeholder: {
					getGradient(from: trip.color)
				}
				.frame(height: 150)
				.cornerRadius(10)
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
				// trigger to update photo in firebase
				.onChange(of: selectedItems) { newItems in
					guard let selectedItem = newItems.first else { return }
					Task {
						if let selectedAsset = try? await selectedItem.loadTransferable(type: Data.self) {
							// Upload to Firebase Storage via TripRepository
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
			// Display trip name and dates
			Text(trip.name)
				.font(.title3.bold())
				.padding([.leading])
				.padding(.top, 6)
				.foregroundColor(.black)
			
			Text("\(trip.startDate) - \(trip.endDate)")
				.font(.subheadline)
				.foregroundColor(.gray)
				.padding([.leading, .bottom])
		}
		.background(Color.white)
		.cornerRadius(15)
		.shadow(radius: 5)
		.padding(.horizontal)
	}
	
	func getColor(from colorName: String) -> Color {
		switch colorName.lowercased() {
		case "blue": return Color.blue
		case "red": return Color.red
		case "green": return Color.green
		case "yellow": return Color.yellow
		case "purple": return Color.purple
		case "orange": return Color.orange
		case "gray": return Color.gray
		default: return Color.gray // Fallback color
		}
	}
	
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

struct TripCardView_Previews: PreviewProvider {
  static var previews: some View {
		TripCardView(trip: Trip.example, tripRepository: TripRepository())
    .previewLayout(.sizeThatFits)
  }
}
