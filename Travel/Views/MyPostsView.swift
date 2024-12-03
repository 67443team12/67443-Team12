//
//  MyPostsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct MyPostsView: View {
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack(spacing: 16) {
      // Custom back button and title
      HStack {
        Button(action: {
          presentationMode.wrappedValue.dismiss() // Dismiss the view
        }) {
          Image(systemName: "chevron.left")
            .font(.title2.bold())
            .foregroundColor(.accentColor)
        }
        .padding(.leading, 10)
        
        Spacer()
        
        Text("My Posts")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.trailing, 25)
        
        Spacer()
      }
      .frame(maxWidth: .infinity) // Ensure the title centers properly
      .padding(.top, 10)
      .padding(.horizontal, 10)
      .navigationBarBackButtonHidden(true) // Hide default back button
      
      // Posts with logged-in userId
      ScrollView {
        ForEach(filterPostsByUserId(posts: postRepository.posts, userId: userRepository.users[0].id), id: \.id) { post in
          MyPostCardView(post: post, postRepository: postRepository, userRepository: userRepository)
        }
      }
    }
    .navigationBarHidden(true) // Hide the default navigation bar if needed
  }
  
  func filterPostsByUserId(posts: [Post], userId: String) -> [Post] {
    // Filter the posts array where userId matches the given userId string
    return posts.filter { $0.userId == userId }
  }
}
