//
//  UserRepository.swift
//  Travel
//
//  Created by k mao on 11/24/24.
//

import Combine
import FirebaseFirestore

class UserRepository: ObservableObject {
  // Firestore collection path
  private var path: String = "users"
  private var store = Firestore.firestore()
  
  // Published variable to store fetched trips
  @Published var users: [User] = []
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    self.get()
  }
  
  func get() {
    // Listen to Firestore changes and fetch trip data
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error fetching users: \(error.localizedDescription)")
          return
        }
        
        // Map the documents to Trip model instances
        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
      }
  }
  
  func editUser(userId: String, updatedUser: User) {
    // Query Firestore to find the document with the specified 'id' field
    store.collection(path)
        .whereField("id", isEqualTo: userId)
        .getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            
            // Ensure a document with the specified 'id' was found
            guard let document = querySnapshot?.documents.first else {
                print("No user found with id: \(userId)")
                return
            }
            
            // Update the document with the new data
          document.reference.updateData(updatedUser.toDictionary()) { error in
                if let error = error {
                    print("Error updating user: \(error.localizedDescription)")
                } else {
                    print("User with id \(userId) successfully updated.")
                }
            }
        }
    
    self.get()
    
  }
  
}
