//
//  PostCardView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/24.
//

import SwiftUI

struct PostCardView: View {
  @Binding var post: Post
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository

  var body: some View {
    NavigationLink(destination: PostDetailView(post: $post, postRepository: postRepository, userRepository: userRepository)) {
      VStack(alignment: .leading, spacing: 0) {
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

        VStack(alignment: .leading, spacing: 8) {
          Text(post.title)
            .font(.title3.bold())
            .foregroundColor(.black)

          HStack {
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
  
  func getUserPhoto(userId: String) -> String {
      // Search for the user with the given ID in userRepository.users
      if let user = userRepository.users.first(where: { $0.id == userId }) {
          return user.photo
      }
      // Return nil if the user is not found
      return ""
  }
  
  func getUserName(userId: String) -> String {
      // Search for the user with the given ID in userRepository.users
      if let user = userRepository.users.first(where: { $0.id == userId }) {
          return user.name
      }
      // Return nil if the user is not found
      return ""
  }
  
  func isBookmarked(post: Post, user: User) -> Bool {
    if user.Bookmarks.contains(post.id) {
      return true
    }
    return false
  }
  
  
}




