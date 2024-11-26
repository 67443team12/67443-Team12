//
//  EditMeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct EditMeView: View {
	@ObservedObject var userRepository: UserRepository
	
	@State var id: String
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
					Text("User Name: ")
					TextField("Name", text: $newName)
				}
					.padding(.vertical, 10)
				
				
				Button("Save Changes") {
					let updatedUser = User(
						id: id,
						name: newName,
						photo: newImage,
						Posts: userRepository.users[0].Posts,
						Bookmarks: userRepository.users[0].Bookmarks,
						Trips: userRepository.users[0].Trips,
						Friends: userRepository.users[0].Friends,
						Requests: userRepository.users[0].Requests
					)
					
					userRepository.editUser(userId: userRepository.users[0].id, updatedUser: updatedUser)

				}
			}
		}
	}
}
