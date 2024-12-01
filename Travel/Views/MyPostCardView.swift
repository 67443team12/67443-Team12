//
//  MyPostCardView.swift
//  Travel
//
//  Created by k mao on 12/1/24.
//

import SwiftUI

struct MyPostCardView: View {
  var post: Post
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  
  var body: some View {
    NavigationLink(destination: MyPostDetailView(post: post, postRepository: postRepository, userRepository: userRepository)) {
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
              AsyncImage(url: URL(string: post.userPhoto)) { image in
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              } placeholder: {
                Circle()
                  .fill(Color.blue)
              }
              .frame(width: 30, height: 30)
              .clipShape(Circle())

              Text(post.userName)
                .font(.headline)
                .foregroundColor(.black)
            }

            Spacer()

//            Button(action: {
//              postRepository.toggleMyBookmark(postId: post.id)
//            }) {
//              Image(systemName: post.ifBookmarked ? "bookmark.fill" : "bookmark")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 28, height: 25)
//                .foregroundColor(post.ifBookmarked ? Color("AccentColor") : Color("AccentColor"))
//            }
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
}

