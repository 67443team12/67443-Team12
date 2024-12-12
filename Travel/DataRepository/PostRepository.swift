//
//  PostRepository.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Combine

class PostRepository: ObservableObject {
  // Properties
  private var path: String = "posts"
  private var store = Firestore.firestore()
  private var storage = Storage.storage()
  @Published var posts: [Post] = []
  private var cancellables: Set<AnyCancellable> = []

  // Initializer
  init() {
    self.get()
  }

  // Fetches posts from Firestore and listens for real-time updates
  func get() {
    store.collection(path)
      .order(by: "time", descending: true)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error fetching posts: \(error.localizedDescription)")
          return
        }
        guard let documents = querySnapshot?.documents else { return }
        let fetchedPosts = documents.compactMap { document in
          try? document.data(as: Post.self)
        }
        DispatchQueue.main.async {
          self.posts = fetchedPosts
        }
      }
  }

  // Adds a new post to Firestore
  func addPost(_ post: Post) {
    do {
      try store.collection(path).document(post.id).setData(from: post)
      DispatchQueue.main.async {
        self.posts.insert(post, at: 0)
      }
    } catch {
      print("Error adding post: \(error.localizedDescription)")
    }
  }
  
  // Toggles the bookmark status of a post
  func toggleBookmark(for post: Post) {
    var updatedPost = post
    updatedPost.ifBookmarked.toggle()
    savePost(updatedPost)
  }

  // Adds a comment to a post and updates Firestore
  func addComment(to post: Post, comment: Comment) {
    var updatedPost = post
    updatedPost.comments.insert(comment, at: 0)
    savePost(updatedPost)
  }

  // Saves an updated post to Firestore
  private func savePost(_ post: Post) {
    do {
      try store.collection(path).document(post.id).setData(from: post)
    } catch {
      print("Error saving post: \(error.localizedDescription)")
    }
  }

  // Uploads an image to Firebase Storage and retrieves the download URL
  func uploadPhoto(_ image: UIImage, completion: @escaping (String?) -> Void) {
    let storageRef = storage.reference().child("post_images/\(UUID().uuidString).jpg")
    guard let imageData = image.jpegData(compressionQuality: 0.8) else {
      print("Error: Unable to compress image.")
      completion(nil)
      return
    }
    storageRef.putData(imageData, metadata: nil) { _, error in
      if let error = error {
        print("Error uploading image: \(error.localizedDescription)")
        completion(nil)
        return
      }
      storageRef.downloadURL { url, error in
        if let error = error {
          print("Error retrieving download URL: \(error.localizedDescription)")
          completion(nil)
        } else {
          completion(url?.absoluteString)
        }
      }
    }
  }
}
