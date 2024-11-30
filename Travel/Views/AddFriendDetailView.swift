//
//  AddFriendDetailView.swift
//  Travel
//
//  Created by Emma Shi on 11/26/24.
//

import SwiftUI

struct AddFriendDetailView: View {
	var user: User
	@ObservedObject var userRepository: UserRepository
	@State private var showAlert: Bool = false
	
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		VStack {
			HStack {
				AsyncImage(url: URL(string: user.photo)) { image in
					image.resizable()
				} placeholder: {
					Color.gray
				}
				.frame(width: 100, height: 100)
				.clipShape(Circle())
				.padding(.leading, 20)
				VStack(alignment: .leading) {
					Text(user.name)
						.font(.largeTitle)
						.fontWeight(.semibold)
					Text("ID: \(user.id)")
						.fontWeight(.semibold)
				}
				.padding(.leading, 20)
				Spacer()
			}
			.padding(.vertical, 30)
			Button(action: {
				// hard code current user here
				userRepository.sendRequest(currUser: userRepository.users[0], request: user)
				showAlert = true
			}) {
				ZStack {
					Rectangle()
						.fill(Color("LightPurple"))
						.frame(height: 70)
					Text("Send Friend Request")
						.fontWeight(.bold)
						.foregroundColor(Color.black)
				}
			}.alert(isPresented: $showAlert) {
				Alert(
					title: Text("Request Sent"),
					message: Text("Your friend request is sent to \(user.name)!"),
					dismissButton: .default(Text("OK")) {
						presentationMode.wrappedValue.dismiss()
					}
				)
			}
			Spacer()
		}
	}
}
