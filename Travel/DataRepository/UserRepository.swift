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
	@Published var filteredUsers: [User] = []
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
	
	func searchById(searchText: String) {
		guard let currentUser = users.first else {
			filteredUsers = []
			return
		}
		
		if searchText == "" {
			filteredUsers = []
		} else {
			filteredUsers = users.filter { user in
				// only shows users that are not friends with the current user,
				// current user has not sent a request to, and not the current user
				user.id.hasPrefix(searchText) && !currentUser.Friends.contains(user.id) && !user.Requests.contains(currentUser.id) && user.id != currentUser.id
			}
		}
	}
	
	func sendRequest(currUser: User, request: User) {
		var newUserRequests = request.Requests
		newUserRequests.append(currUser.id)
		
		let updatedUser = User(
			id: request.id,
			name: request.name,
			photo: request.photo,
			Posts: request.Posts,
			Bookmarks: request.Bookmarks,
			Trips: request.Trips,
			Friends: request.Friends,
			Requests: newUserRequests
		)
		
		self.editUser(userId: request.id, updatedUser: updatedUser)
	}
	
	func acceptRequest(currUser: User, request: User) {
		var newCurrUserFriends = currUser.Friends
		newCurrUserFriends.append(request.id)
		
		var newCurrUserRequests = currUser.Requests
		newCurrUserRequests = newCurrUserRequests.filter { $0 != request.id }
		
		var newUsersFriends = request.Friends
		newUsersFriends.append(currUser.id)
		
		let updatedCurrUser = User(
			id: currUser.id,
			name: currUser.name,
			photo: currUser.photo,
			Posts: currUser.Posts,
			Bookmarks: currUser.Bookmarks,
			Trips: currUser.Trips,
			Friends: newCurrUserFriends,
			Requests: newCurrUserRequests
		)
		
		let updatedUser = User(
			id: request.id,
			name: request.name,
			photo: request.photo,
			Posts: request.Posts,
			Bookmarks: request.Bookmarks,
			Trips: request.Trips,
			Friends: newUsersFriends,
			Requests: request.Requests
		)
		
		self.editUser(userId: currUser.id, updatedUser: updatedCurrUser)
		self.editUser(userId: request.id, updatedUser: updatedUser)
	}
	
}
