//
//  PostDetailView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/24.
//

import SwiftUI

// View displaying detailed information about a post
struct PostDetailView: View {
  @Binding var post: Post
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  @State private var newComment: String = ""

  var body: some View {
    VStack(spacing: 0) {
      // Navigation bar with back button, author info, and bookmark button
      HStack {
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          Image(systemName: "chevron.left")
            .font(.title2.bold())
            .foregroundColor(Color("AccentColor"))
        }
        .padding(.leading)
        .padding(.trailing, 5)

        HStack {
          AsyncImage(url: URL(string: getUserPhoto(userId: post.userId))) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            Circle()
              .fill(Color.blue)
          }
          .frame(width: 40, height: 40)
          .clipShape(Circle())
          .padding(.trailing, 5)

          Text(getUserName(userId: post.userId))
            .font(.title3.bold())
        }

        Spacer()

        Button(action: {
          postRepository.toggleBookmark(for: post)
          userRepository.toggleUserBookmark(postId: post.id, userId: userRepository.users[0].id)
        }) {
          Image(systemName: isBookmarked(post: post, user: userRepository.users[0]) ? "bookmark.fill" : "bookmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 25)
            .foregroundColor(isBookmarked(post: post, user: userRepository.users[0]) ? Color("AccentColor") : Color("AccentColor"))
        }
        .padding(.trailing)
      }

      // Post content
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          // Post photo
          AsyncImage(url: URL(string: post.photo)) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } placeholder: {
            Rectangle()
              .fill(Color(.systemGray3))
          }
          .frame(height: 250)
          .frame(maxWidth: .infinity)
          .clipped()

          // Post title
          Text(post.title)
            .font(.title2.bold())
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("LightPurple"))
            .cornerRadius(8)
            .padding(.horizontal)

          // Post content
          Text(post.content)
            .font(.title3)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("LightPurple"))
            .cornerRadius(8)
            .padding(.horizontal)

          // Post time
          Text(post.formattedTime)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.horizontal)

          // Comments section
          VStack(alignment: .leading, spacing: 16) {
            Text("Comments")
              .font(.title3.bold())
              .padding(.horizontal)

            // Add new comment
            HStack {
              TextField("Leave a comment", text: $newComment)
                .padding()
                .background(Color("LightPurple"))
                .cornerRadius(8)

              if !newComment.isEmpty {
                Button(action: {
                  let newCommentObject = Comment(
                    id: UUID().uuidString,
                    userId: userRepository.users[0].id,
                    userName: userRepository.users[0].name,
                    userPhoto: userRepository.users[0].photo,
                    content: newComment
                  )
                  postRepository.addComment(to: post, comment: newCommentObject)
                  newComment = ""
                }) {
                  Image(systemName: "checkmark")
                    .foregroundColor(.black)
                }
              }
            }
            .padding(.horizontal)

            // Display existing comments
            ForEach(post.comments, id: \.id) { comment in
              HStack(alignment: .top) {
                AsyncImage(url: URL(string: getUserPhoto(userId: comment.userId))) { image in
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                } placeholder: {
                  Circle()
                    .fill(Color.blue)
                }
                .frame(width: 30, height: 30)
                .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                  Text(getUserName(userId: comment.userId))
                    .font(.headline)
                  Text(comment.content)
                    .font(.body)
                    .foregroundColor(.gray)
                }
                Spacer()
              }
              .padding(.horizontal)
            }
          }
        }
        .padding(.vertical)
      }
      .padding(.top, 3)
    }
    .navigationBarHidden(true)
    .background(Color("Cream"))
  }

  // Returns the photo URL of the specified user
  func getUserPhoto(userId: String) -> String {
    userRepository.users.first(where: { $0.id == userId })?.photo ?? ""
  }

  // Returns the name of the specified user
  func getUserName(userId: String) -> String {
    userRepository.users.first(where: { $0.id == userId })?.name ?? ""
  }

  // Checks if the specified post is bookmarked by the given user
  func isBookmarked(post: Post, user: User) -> Bool {
    user.Bookmarks.contains(post.id)
  }
}
