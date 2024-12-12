//
//  NewPostView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/25.
//

import SwiftUI
import PhotosUI

// View for creating a new post with a photo, title, and content
struct NewPostView: View {
  @ObservedObject var postRepository: PostRepository
  @State private var selectedPhotoItem: PhotosPickerItem?
  @State private var selectedPhoto: UIImage?
  @State private var title: String = ""
  @State private var content: String = ""
  @State private var isUploading = false
  @State private var showErrorAlert = false
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    VStack(spacing: 16) {
      // Header with back button and title
      HStack {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "chevron.left")
            .font(.title2.bold())
            .foregroundColor(Color("AccentColor"))
        }
        .padding(.leading)

        Spacer()

        Text("Create a New Post")
          .font(.title3.bold())
          .foregroundColor(.black)
          .padding(.trailing, 20)

        Spacer()
      }
      .padding(.top)

      // Display selected photo or photo picker
      if let photo = selectedPhoto {
        Image(uiImage: photo)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: 250)
          .frame(maxWidth: .infinity)
          .clipped()
      } else {
        PhotosPicker(
          selection: $selectedPhotoItem,
          matching: .images,
          photoLibrary: .shared()
        ) {
          ZStack {
            Rectangle()
              .fill(Color(.systemGray3))
              .frame(height: 250)
              .frame(maxWidth: .infinity)
              .overlay(
                Image(systemName: "photo")
                  .font(.largeTitle)
                  .foregroundColor(.white)
              )
          }
        }
        .onChange(of: selectedPhotoItem) { newItem in
          Task {
            // Load selected photo
            if let data = try? await newItem?.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
              selectedPhoto = image
            }
          }
        }
      }

      // Title input field
      VStack(alignment: .leading, spacing: 8) {
        Text("Title")
          .font(.title3.bold())
          .foregroundColor(.gray)

        TextField("", text: $title)
          .padding()
          .background(Color("LightPurple"))
          .cornerRadius(8)
          .font(.title2.bold())
      }
      .padding(.horizontal)

      // Content input field
      VStack(alignment: .leading, spacing: 8) {
        Text("Content")
          .font(.title3.bold())
          .foregroundColor(.gray)

        ZStack(alignment: .topLeading) {
          RoundedRectangle(cornerRadius: 8)
            .fill(Color("LightPurple"))
            .frame(height: 200)

          CustomTextEditor(
            text: $content,
            placeholder: "",
            backgroundColor: UIColor(named: "LightPurple") ?? UIColor.systemGray,
            font: UIFont.preferredFont(forTextStyle: .title2)
          )
          .frame(height: 200)
          .padding(.horizontal, 10)
          .cornerRadius(8)
        }
      }
      .padding(.horizontal)

      // Buttons for canceling or posting
      HStack(spacing: 20) {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          Text("Cancel")
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("LightPurple"))
            .cornerRadius(8)
        }

        Button(action: {
          createPost()
        }) {
          if isUploading {
            ProgressView()
              .padding()
              .frame(maxWidth: .infinity)
          } else {
            Text("Post")
              .font(.headline)
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color("AccentColor"))
              .foregroundColor(.white)
              .cornerRadius(8)
          }
        }
        .disabled(isUploading)
      }
      .padding()
      .alert("Photo Upload Failed", isPresented: $showErrorAlert) {
        Button("OK", role: .cancel) {}
      }
    }
    .navigationBarHidden(true)
    .navigationTitle("Create Post")
    .navigationBarTitleDisplayMode(.inline)
    .background(Color("Cream"))
  }
  
  // Creates a new post and uploads the selected photo
  private func createPost() {
    guard let photo = selectedPhoto, !title.isEmpty, !content.isEmpty else { return }
    isUploading = true
    postRepository.uploadPhoto(photo) { photoURL in
      if let photoURL = photoURL {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: Date())
        let newPost = Post(
          id: UUID().uuidString,
          title: title,
          time: formattedDate,
          content: content,
          userId: "Alice215",
          userName: "Alice",
          userPhoto: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/alice-icon.png?alt=media&token=1b8e454a-cec1-4433-a441-2f4d7085898d",
          ifBookmarked: false,
          photo: photoURL
        )
        postRepository.addPost(newPost)
        isUploading = false
        presentationMode.wrappedValue.dismiss()
      } else {
        isUploading = false
        showErrorAlert = true
      }
    }
  }
}
