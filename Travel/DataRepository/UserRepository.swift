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
	
	func addTripToUser(currUser: User, newTripId: String) {
		var newUserTrips = currUser.Trips
		newUserTrips.append(newTripId)
		
		let updatedUser = User(
			id: currUser.id,
			name: currUser.name,
			photo: currUser.photo,
			Posts: currUser.Posts,
			Bookmarks: currUser.Bookmarks,
			Trips: newUserTrips,
			Friends: currUser.Friends,
			Requests: currUser.Requests
		)
		
		self.editUser(userId: currUser.id, updatedUser: updatedUser)
	}
	
	func deleteFriend(currUser: User, friend: User) {
		let currNewFriends = currUser.Friends.filter { $0 != friend.id }
		let userNewFriends = friend.Friends.filter { $0 != currUser.id }
		
		let updatedCurrUser = User(
			id: currUser.id,
			name: currUser.name,
			photo: currUser.photo,
			Posts: currUser.Posts,
			Bookmarks: currUser.Bookmarks,
			Trips: currUser.Trips,
			Friends: currNewFriends,
			Requests: currUser.Requests
		)
		let updatedUser = User(
			id: friend.id,
			name: friend.name,
			photo: friend.photo,
			Posts: friend.Posts,
			Bookmarks: friend.Bookmarks,
			Trips: friend.Trips,
			Friends: userNewFriends,
			Requests: friend.Requests
		)
		
		self.editUser(userId: currUser.id, updatedUser: updatedCurrUser)
		self.editUser(userId: friend.id, updatedUser: updatedUser)
	}
	
}
