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

  var body: some View {
    NavigationLink(destination: PostDetailView(post: $post, postRepository: postRepository)) {
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

            Button(action: {
              postRepository.toggleBookmark(for: post)
            }) {
              Image(systemName: post.ifBookmarked ? "bookmark.fill" : "bookmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 25)
                .foregroundColor(post.ifBookmarked ? Color("AccentColor") : Color("AccentColor"))
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
}

struct PostCardView_Previews: PreviewProvider {
  static var previews: some View {
    let postRepository = PostRepository()
    PostCardView(post: .constant(Post.example1), postRepository: postRepository)
      .previewLayout(.sizeThatFits)
  }
}
