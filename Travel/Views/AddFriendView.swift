//
//  AddFriendView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

struct AddFriendView: View {
	@ObservedObject var userRepository: UserRepository
	@State private var searchText: String = ""
	@State private var showAlert = false
	
	var body: some View {
		VStack(spacing: 15) {
			HStack {
				TextField("Search account id...", text: $searchText)
					.padding(.leading, 10) // Extra padding for text
					.padding(.vertical, 15)
					.onChange(of: searchText) { newValue in
						userRepository.searchById(searchText: newValue)
					}
				
				if !searchText.isEmpty {
					Button(action: {
						searchText = ""
					}) {
						Image(systemName: "xmark.circle.fill")
							.foregroundColor(.gray)
					}
					.padding(.trailing, 10)
				}
			}
			.background(Color("LightPurple"))
			.cornerRadius(10)
			.padding(.horizontal, 20)
			.padding(.vertical, 10)
			
			if searchText.isEmpty {
				VStack(spacing: 15) {
					Text("New Friend Requests")
						.font(.title3)
						.fontWeight(.semibold)
						.padding(.leading, 20)
						.frame(maxWidth: .infinity, alignment: .leading)
					ForEach(userRepository.users.filter {userRepository.users[0].Requests.contains($0.id)}) { request in
						RequestRowView(userRepository: userRepository, request: request, showAlert: $showAlert)
					}
					Spacer()
				}
			} else {
				// search user by id results
				List {
					ForEach(userRepository.filteredUsers) { user in
						NavigationLink(destination: AddFriendDetailView(user: user, userRepository: userRepository)) {
							HStack(spacing: 20) {
								AsyncImage(url: URL(string: user.photo)) { image in
									image.resizable()
								} placeholder: {
									Color.gray
								}
								.frame(width: 50, height: 50)
								.clipShape(Circle())
								VStack(alignment: .leading) {
									Text(user.name)
										.fontWeight(.semibold)
									Text("ID: \(user.id)")
										.font(.caption)
								}
								Spacer()
							}
						}
					}
				}
				.listStyle(PlainListStyle())
			}
		}
		.navigationTitle("Add Friend")
		.navigationBarTitleDisplayMode(.inline)
//		.onAppear() {
//			userRepository.get()
//		}
	}
}

//#Preview {
//	AddFriendView(userRepository: UserRepository())
//}
