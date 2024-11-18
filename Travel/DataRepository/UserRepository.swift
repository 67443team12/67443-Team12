//
//  UserRepository.swift
//  Travel
//
//  Created by Emma Shi on 11/17/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import Combine

class UserRepository: ObservableObject {
	private var path: String = "users"
	private var store = Firestore.firestore()
	
	@Published var users: [User] = []
	private var cancellables: Set<AnyCancellable> = []
	
	init() {
		self.get()
	}
	
	func get() {
		// Listen to Firestore changes and fetch post data
		store.collection(path)
			.addSnapshotListener { querySnapshot, error in
				if let error = error {
					print("Error fetching users: \(error.localizedDescription)")
					return
				}
				
				// Map the documents to Post model instances
				self.users = querySnapshot?.documents.compactMap { document in
					try? document.data(as: User.self)
				} ?? []
			}
	}
	
}
