//
//  RequestRowView.swift
//  Travel
//
//  Created by Emma Shi on 11/26/24.
//

import SwiftUI

struct RequestRowView: View {
	var request: User
	
	@State private var showAlert = false
	
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
				// need a confirm request function
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
					message: Text("You and \(request.name) are now friends!"),
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
