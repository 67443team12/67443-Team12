//
//  PostRepository.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import FirebaseFirestore
import Combine

class PostRepository: ObservableObject {
  private var path: String = "posts"
  private var store = Firestore.firestore()
  
  @Published var posts: [Post] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }
  
  func get() {
    // Listen to Firestore changes and fetch post data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error fetching posts: \(error.localizedDescription)")
          return
        }
        
        // Map the documents to Post model instances
        self.posts = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Post.self)
        } ?? []
      }
  }
  
  func addPost(_ post: Post) {
    // Function to add a new post to Firestore
    do {
      try store.collection(path).document(post.id).setData(from: post)
    } catch {
      print("Error adding post: \(error.localizedDescription)")
    }
  }
}
