//
//  MeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct MeView: View {
	@EnvironmentObject var aliceVM: MockUser
	
	var body: some View {
		NavigationView {
			VStack(spacing: 40) {
				HStack {
					Text("Me")
						.font(.largeTitle)
						.fontWeight(.bold)
						.padding(.top, 15)
						.padding(.leading, 20)
					Spacer()
				}
				
        HStack {
					AsyncImage(url: URL(string: aliceVM.user.photo)) { image in
						image.resizable()
					} placeholder: {
						Color.gray
					}
						.frame(width: 100, height: 100)
						.clipShape(Circle())
						.padding(.leading, 20)
					VStack(alignment: .leading) {
						Text(aliceVM.user.name)
							.font(.largeTitle)
							.fontWeight(.semibold)
						Text("ID: \(aliceVM.user.id)")
							.fontWeight(.semibold)
					}
						.padding(.leading, 20)
					Spacer()
					// edit profile action not yet implemented
					NavigationLink(destination: EditMeView()) {
						Image(systemName: "ellipsis.circle")
							.font(.title)
							.padding(.trailing, 20)
							.padding(.bottom, 25)
					}
				}
        
				List {
					NavigationLink(
						destination: MyPostsView(),
						label: {
							Text("My Posts")
						})
					NavigationLink(
						destination: MyPostsView(),
						label: {
							Text("Bookmarks")
						})
				}
				.listStyle(PlainListStyle())
				.scrollDisabled(true)
			}
		}
	}
}

#Preview {
	MeView()
		.environmentObject(MockUser(user: User.example))
}
