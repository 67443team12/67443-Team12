//
//  MeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct MeView: View {
//	@EnvironmentObject var aliceVM: MockUser
  let currUser: User
  let userRepository: UserRepository
	
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
					Circle()
						.fill(.blue)
						.frame(width: 100, height: 100)
						.padding(.leading, 20)
					VStack(alignment: .leading) {
            Text(currUser.name)
							.font(.largeTitle)
							.fontWeight(.semibold)
            Text("ID: \(currUser.id)")
							.fontWeight(.semibold)
					}
						.padding(.leading, 20)
					Spacer()
					// edit profile action not yet implemented
          NavigationLink(destination: EditMeView(currUser: currUser, userRepository: userRepository, newId: currUser.id, newName: currUser.name, newImage: currUser.photo)) {
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

//#Preview {
//	MeView()
//		.environmentObject(MockUser(user: User.example))
//}
