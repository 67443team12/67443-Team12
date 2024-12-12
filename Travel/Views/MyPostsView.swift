//
//  MyPostsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

// View for displaying the posts created by the current user
struct MyPostsView: View {
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      VStack {
        // Header section with title
        HStack {
          Text("My Posts")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)
          Spacer()
        }

        // Scroll view displaying the user's posts
        ScrollView {
          ForEach($postRepository.posts, id: \.id) { $post in
            if post.userId == userRepository.users[0].id {
              PostCardView(post: $post, postRepository: postRepository, userRepository: userRepository)
            }
          }
        }
      }
      .navigationBarHidden(true)
      .background(Color("Cream"))
    }
  }
}
