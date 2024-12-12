//
//  EditMeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import FirebaseFirestore

// View for editing the user's profile, including name and profile photo
struct EditMeView: View {
  @ObservedObject var userRepository: UserRepository
  @State var id: String
  @State var newName: String
  @State var newImage: String
  @State private var isShowingPicker = false
  @State private var selectedItems: [PhotosPickerItem] = []
  @State private var selectedPhotoData: Data?
  
  var body: some View {
    ZStack {
      Color("Cream")
        .edgesIgnoringSafeArea(.all)

      Form {
        Section(header: Text("Edit Profile").font(.headline)) {
          // Button to upload a new profile photo
          Button(action: {
            isShowingPicker = true
          }) {
            HStack {
              Text("Upload New Profile Photo")
              Image(systemName: "photo.on.rectangle.angled")
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .shadow(color: .black, radius: 2)
            }
          }
          .photosPicker(
            isPresented: $isShowingPicker,
            selection: $selectedItems,
            maxSelectionCount: 1,
            matching: .images
          )
          .onChange(of: selectedItems) { newItems in
            // Handle photo selection
            guard let selectedItem = newItems.first else { return }
            Task {
              if let selectedAsset = try? await selectedItem.loadTransferable(type: Data.self) {
                selectedPhotoData = selectedAsset
                print("Photo selected and stored temporarily.")
              }
            }
          }

          // Text field for updating the user's name
          HStack {
            Text("User Name: ")
              .fontWeight(.bold)
            TextField("Name", text: $newName)
          }
          .padding(.vertical, 10)

          // Button to save changes to profile
          Button("Save Changes") {
            // Create an updated user object
            let updatedUser = User(
              id: id,
              name: newName,
              photo: newImage,
              Posts: userRepository.users[0].Posts,
              Bookmarks: userRepository.users[0].Bookmarks,
              Trips: userRepository.users[0].Trips,
              Friends: userRepository.users[0].Friends,
              Requests: userRepository.users[0].Requests
            )
            
            // Update the user's data in the repository
            userRepository.editUser(userId: userRepository.users[0].id, updatedUser: updatedUser)

            // Check if a photo is selected for upload
            guard let photoData = selectedPhotoData else {
              print("No photo selected to upload.")
              return
            }

            // Upload the photo to Firebase Storage and update the user's profile photo URL
            userRepository.uploadPhotoToStorage(imageData: photoData, userId: userRepository.users[0].id) { photoURL in
              if let photoURL = photoURL {
                print("Photo uploaded and URL updated: \(photoURL)")
              }
            }
          }
        }
      }
      .scrollContentBackground(.hidden)
      .background(Color("Cream"))
    }
  }
}
