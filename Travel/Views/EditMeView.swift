//
//  EditMeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct EditMeView: View {
	let currUser: User
	let userRepository: UserRepository
	
	@State var newId: String
	@State var newName: String
	@State var newImage: String
	
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
				HStack {
					Text("User ID: ")
					TextField("User ID", text: $newId)
				}
				
				HStack {
					Text("Displayed Name: ")
					TextField("Name", text: $newName)
				}
					.padding(.vertical, 10)
				
				
				Button("Save Changes") {
					let updatedUser = User(
						id: newId,
						name: newName,
						photo: newImage,
						Posts: currUser.Posts,
						Bookmarks: currUser.Bookmarks,
						Trips: currUser.Trips,
						Friends: currUser.Friends,
						Requests: currUser.Requests
					)
					
					userRepository.editUser(userId: currUser.id, updatedUser: updatedUser)

				}
			}
		}
	}
}
