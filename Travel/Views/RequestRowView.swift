//
//  RequestRowView.swift
//  Travel
//
//  Created by Emma Shi on 11/26/24.
//

import SwiftUI

struct RequestRowView: View {
	@ObservedObject var userRepository: UserRepository
	var request: User
	
	@Binding var showAlert: Bool
	
	var body: some View {
		HStack(spacing: 20) {
			AsyncImage(url: URL(string: request.photo)) { image in
				image.resizable()
			} placeholder: {
				Color.gray
			}
			.frame(width: 50, height: 50)
			.clipShape(Circle())
			VStack(alignment: .leading) {
				Text(request.name)
					.fontWeight(.semibold)
				Text("ID: \(request.id)")
					.font(.caption)
			}
			Spacer()
			Button(action: {
				userRepository.acceptRequest(currUser: userRepository.users[0], request: request)
				showAlert = true
			}) {
				Text("Accept")
					.padding(12)
					.background(Color("LightPurple"))
					.foregroundColor(Color.black)
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}
			.alert(isPresented: $showAlert) {
				Alert(
					title: Text("Request Accepted"),
					message: Text("You are now officially friends! Hooraay!"),
					dismissButton: .default(Text("OK"))
				)
			}
		}
		.padding(.horizontal, 20)
	}
}

//#Preview {
//    RequestRowView()
//}
