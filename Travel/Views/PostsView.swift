//
//  PostsView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/11/24.
//

import SwiftUI

struct PostsView: View {
  @StateObject private var postRepository = PostRepository()

  var body: some View {
    NavigationView {
      VStack {
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

        ScrollView {
          ForEach($postRepository.posts, id: \.id) { $post in
            PostCardView(post: $post, postRepository: postRepository)
          }
        }
      }
      .navigationBarHidden(true)
    }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView()
  }
}
