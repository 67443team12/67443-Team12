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

struct EditMeView: View {
  @ObservedObject var userRepository: UserRepository
  
  @State var id: String
  @State var newName: String
  @State var newImage: String
  
  
  @State private var isShowingPicker = false
  @State private var selectedItems: [PhotosPickerItem] = []
  @State private var selectedPhotoData: Data?
  
  //  init(currUser: User, userRepository: UserRepository, newId: String, newImage: String) {
  //    self.currUser = currUser
  //    self.userRepository = userRepository
  //    _newId = State(initialValue: currUser.id)
  //    _newImage = State(initialValue: currUser.photo)
  //  }
  
  var body: some View {
    
    Form {
      Section(
        header: Text("Edit Profile").font(.headline)
      ) {
        
        

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
      
        .photosPicker(isPresented: $isShowingPicker, selection: $selectedItems, maxSelectionCount: 1, matching: .images)
        //         trigger to update photo in firebase
        .onChange(of: selectedItems) { newItems in
                        guard let selectedItem = newItems.first else { return }
                        Task {
                            // Load the selected photo data and store it temporarily
                            if let selectedAsset = try? await selectedItem.loadTransferable(type: Data.self) {
                                selectedPhotoData = selectedAsset
                                print("Photo selected and stored temporarily.")
                            }
                        }
                    }
        
        
        
        
        HStack {
          Text("User Name: ")
          TextField("Name", text: $newName)
        }
        .padding(.vertical, 10)
        
        
        Button("Save Changes") {
          
          
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
          
          userRepository.editUser(userId: userRepository.users[0].id, updatedUser: updatedUser)
          
          
          guard let photoData = selectedPhotoData else {
              print("No photo selected to upload.")
            return
          }
          // Upload photo to Firebase Storage
          userRepository.uploadPhotoToStorage(imageData: photoData, userId: userRepository.users[0].id) { photoURL in
              if let photoURL = photoURL {
                  print("Photo uploaded and URL updated: \(photoURL)")
              }
            
          }
        }
        
      }
    }
  }
}
