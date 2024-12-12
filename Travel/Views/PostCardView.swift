//
//  PostCardView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/24.
//

import SwiftUI

// View for representing a single post in a card format
struct PostCardView: View {
  @Binding var post: Post
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository

  var body: some View {
    NavigationLink(destination: PostDetailView(post: $post, postRepository: postRepository, userRepository: userRepository)) {
      VStack(alignment: .leading, spacing: 0) {
        // Post image
        AsyncImage(url: URL(string: post.photo)) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
        } placeholder: {
          Rectangle()
            .fill(Color(.systemGray3))
        }
        .frame(height: 200)
        .clipped()

        // Post details (title, author, bookmark button)
        VStack(alignment: .leading, spacing: 8) {
          Text(post.title)
            .font(.title3.bold())
            .foregroundColor(.black)

          HStack {
            // Author information
            HStack(spacing: 8) {
              AsyncImage(url: URL(string: getUserPhoto(userId: post.userId))) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              } placeholder: {
                Circle()
                  .fill(Color.blue)
              }
              .frame(width: 30, height: 30)
              .clipShape(Circle())

              Text(getUserName(userId: post.userId))
                .font(.headline)
                .foregroundColor(.black)
            }

            Spacer()

            // Bookmark button
            Button(action: {
              postRepository.toggleBookmark(for: post)
              userRepository.toggleUserBookmark(postId: post.id, userId: userRepository.users[0].id)
            }) {
              Image(systemName: isBookmarked(post: post, user: userRepository.users[0]) ? "bookmark.fill" : "bookmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 25)
                .foregroundColor(isBookmarked(post: post, user: userRepository.users[0]) ? Color("AccentColor") : Color("AccentColor"))
            }
          }
        }
        .padding()
        .background(Color("LightPurple"))
      }
    }
    .cornerRadius(10)
    .padding(.horizontal, 25)
    .padding(.bottom, 10)
  }

  // Returns the photo URL of the user who created the post
  func getUserPhoto(userId: String) -> String {
    userRepository.users.first(where: { $0.id == userId })?.photo ?? ""
  }

  // Returns the name of the user who created the post
  func getUserName(userId: String) -> String {
    userRepository.users.first(where: { $0.id == userId })?.name ?? ""
  }

  // Checks if the current user has bookmarked the post
  func isBookmarked(post: Post, user: User) -> Bool {
    user.Bookmarks.contains(post.id)
  }
}
