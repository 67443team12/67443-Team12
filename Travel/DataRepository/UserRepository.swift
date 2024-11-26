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
			// Reference the specific user document by ID
			let userRef = store.collection(path).document(userId)
			
			// Perform the update operation
		userRef.updateData(updatedUser.toDictionary()) { error in
					if let error = error {
							print("Error updating user: \(error.localizedDescription)")
					} else {
							print("User successfully updated.")
					}
			}
	}
	
}
