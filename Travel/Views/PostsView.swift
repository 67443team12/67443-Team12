//
//  PostsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/24.
//

import SwiftUI

// View for displaying a list of posts with an option to create a new post
struct PostsView: View {
  @ObservedObject var userRepository: UserRepository
  @ObservedObject var postRepository: PostRepository

  var body: some View {
    NavigationView {
      VStack {
        // Header with title and "New Post" button
        HStack {
          Text("Posts")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)

          Spacer()

          NavigationLink(destination: NewPostView(postRepository: postRepository)) {
            Image(systemName: "plus.circle")
              .font(.largeTitle)
              .padding(.trailing, 20)
              .padding(.top, 15)
          }
        }

        // List of posts
        ScrollView {
          ForEach($postRepository.posts, id: \.id) { $post in
            PostCardView(post: $post, postRepository: postRepository, userRepository: userRepository)
          }
        }
      }
      .navigationBarHidden(true)
      .background(Color("Cream"))
    }
  }
}
