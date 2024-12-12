//
//  UserRepository.swift
//  Travel
//
//  Created by Kailan Mao on 11/24/24.
//

import Combine
import FirebaseFirestore
import FirebaseStorage

class UserRepository: ObservableObject {
  // Properties
  private var path: String = "users"
  private var store = Firestore.firestore()
  private var storage = Storage.storage()
  @Published var users: [User] = []
  @Published var filteredUsers: [User] = []
  private var cancellables: Set<AnyCancellable> = []
  
  // Initializer
  init() {
    self.get()
  }
  
  // Fetches user data from Firestore and listens for updates in real-time
  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error fetching users: \(error.localizedDescription)")
          return
        }
        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
      }
  }
  
  // Updates the user document in Firestore with new data
  func editUser(userId: String, updatedUser: User) {
    store.collection(path)
      .whereField("id", isEqualTo: userId)
      .getDocuments { querySnapshot, error in
        if let error = error {
          print("Error fetching user document: \(error.localizedDescription)")
          return
        }
        guard let document = querySnapshot?.documents.first else {
          print("No user found with id: \(userId)")
          return
        }
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
  
  // Adds a trip to the current user's list of trips
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
  
  // Deletes a friend from the current user's and the friend's friend lists
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
  
  // Filters users based on their ID and the current user's relationships
  func searchById(searchText: String) {
    guard let currentUser = users.first else {
      filteredUsers = []
      return
    }
    if searchText == "" {
      filteredUsers = []
    } else {
      filteredUsers = users.filter { user in
        user.id.hasPrefix(searchText) && !currentUser.Friends.contains(user.id) && !user.Requests.contains(currentUser.id) && user.id != currentUser.id
      }
    }
  }
  
  // Sends a friend request to another user
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
  
  // Accepts a friend request and updates both users' friend lists
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
  
  // Leave a trip the user created
  func leaveTrip(tripId: String, userId: String) {
    var user = users.first { $0.id == userId }!
    var newTrips = user.Trips.filter { $0 != tripId }
    let updatedUser = User(
      id: user.id,
      name: user.name,
      photo: user.photo,
      Posts: user.Posts,
      Bookmarks: user.Bookmarks,
      Trips: newTrips,
      Friends: user.Friends,
      Requests: user.Requests
    )
    self.editUser(userId: user.id, updatedUser: updatedUser)
  }
  
  // Toggle the status of a user's bookmarked post
  func toggleUserBookmark(postId: String, userId: String) {
    guard let userIndex = users.firstIndex(where: { $0.id == userId }) else {
      print("User not found")
      return
    }
    var user = users[userIndex]
    if user.Bookmarks.contains(postId) {
      user.Bookmarks.removeAll { $0 == postId }
    } else {
      user.Bookmarks.append(postId)
    }
    let updatedUser = User(
      id: user.id,
      name: user.name,
      photo: user.photo,
      Posts: user.Posts,
      Bookmarks: user.Bookmarks,
      Trips: user.Trips,
      Friends: user.Friends,
      Requests: user.Requests
    )
    self.editUser(userId: user.id, updatedUser: updatedUser)
  }
  
  // Update the user's photo
  func updateUserPhotoURL(userId: String, photoURL: String, completion: @escaping (Bool) -> Void) {
    let tripRef = store.collection(path).document(userId)
    tripRef.updateData(["photo": photoURL]) { error in
      if let error = error {
        print("Error updating photo URL: \(error.localizedDescription)")
        completion(false)
        self.get()
        return
      }
      print("Photo URL updated successfully in Firestore.")
      completion(true)
    }
  }
  
  // Uploads a photo to Firebase Storage and updates the user's photo URL in Firestore
  func uploadPhotoToStorage(imageData: Data, userId: String, completion: @escaping (String?) -> Void) {
    let storageRef = storage.reference().child("user_photos/\(UUID().uuidString).jpg")
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpeg"
    storageRef.putData(imageData, metadata: metadata) { metadata, error in
      if let error = error {
        print("Error uploading photo: \(error.localizedDescription)")
        completion(nil)
        return
      }
      storageRef.downloadURL { url, error in
        if let error = error {
          print("Error fetching photo URL: \(error.localizedDescription)")
          completion(nil)
          return
        }
        if let downloadURL = url {
          self.updateUserPhotoURL(userId: userId, photoURL: downloadURL.absoluteString) { success in
            if success {
              completion(downloadURL.absoluteString)
            } else {
              completion(nil)
            }
          }
        }
      }
    }
  }
}
