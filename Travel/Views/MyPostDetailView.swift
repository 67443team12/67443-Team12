//
//  MyPostDetailView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/24.
//

import SwiftUI

struct MyPostDetailView: View {
  var post: Post
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository

  @State private var newComment: String = ""

  var body: some View {
    VStack(spacing: 0) {
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
          AsyncImage(url: URL(string: post.userPhoto)) { image in
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
          Text(post.userName)
            .font(.title3.bold())
        }

        Spacer()

      }

      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
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

          Text(post.title)
            .font(.title2.bold())
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("LightPurple"))
            .cornerRadius(8)
            .padding(.horizontal)

          Text(post.content)
            .font(.title3)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("LightPurple"))
            .cornerRadius(8)
            .padding(.horizontal)

          Text(post.time)
            .font(.headline)
            .foregroundColor(.gray)
            .padding(.horizontal)

          VStack(alignment: .leading, spacing: 16) {
            Text("Comments")
              .font(.title3.bold())
              .padding(.horizontal)
            
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

            ForEach(post.comments, id: \.id) { comment in
              HStack(alignment: .top) {
                AsyncImage(url: URL(string: comment.userPhoto)) { image in
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
                  Text(comment.userName)
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
}


