//
//  MyBookmarksView.swift
//  Travel
//
//  Created by Kailan Mao on 12/1/24.
//

import SwiftUI

// View for displaying the user's bookmarked posts
struct MyBookmarksView: View {
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      VStack {
        // Header with title
        HStack {
          Text("My Bookmarks")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)
          Spacer()
        }

        // Display bookmarks as a scrollable list
        ScrollView {
          ForEach($postRepository.posts, id: \.id) { $post in
            // Check if the post is bookmarked by the current user
            if userRepository.users[0].Bookmarks.contains(post.id) {
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
