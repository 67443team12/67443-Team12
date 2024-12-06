//
//  MyPostsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct MyPostsView: View {
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("My Posts")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.top, 15)
            .padding(.leading, 20)

          Spacer()

        }

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
  
  func filterPostsByUserId(posts: [Post], userId: String) -> [Post] {
    // Filter the posts array where userId matches the given userId string
    return posts.filter { $0.userId == userId }
  }
}
