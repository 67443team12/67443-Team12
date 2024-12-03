//
//  MeView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct MeView: View {
//	@EnvironmentObject var aliceVM: MockUser
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var postRepository: PostRepository
	
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
          AsyncImage(url: URL(string: userRepository.users[0].photo)) { image in
            image.resizable()
          } placeholder: {
            Color.gray
          }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .padding(.leading, 20)
          
					VStack(alignment: .leading) {
            Text(userRepository.users[0].name)
							.font(.largeTitle)
							.fontWeight(.semibold)
            Text("ID: \(userRepository.users[0].id)")
							.fontWeight(.semibold)
					}
						.padding(.leading, 20)
					Spacer()
          NavigationLink(destination: EditMeView(userRepository: userRepository, id: userRepository.users[0].id, newName: userRepository.users[0].name, newImage: userRepository.users[0].photo)) {
						Image(systemName: "ellipsis.circle")
							.font(.title)
							.padding(.trailing, 20)
							.padding(.bottom, 25)
					}
				}
        
				List {
					NavigationLink(
            destination: MyPostsView(postRepository: postRepository, userRepository: userRepository),
						label: {
							Text("My Posts")
						})
					NavigationLink(
            destination: MyBookmarksView(postRepository: postRepository, userRepository: userRepository),
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
