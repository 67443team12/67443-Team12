//
//  MyBookmarksView.swift
//  Travel
//
//  Created by Kailan Mao on 12/1/24.
//

import SwiftUI

struct MyBookmarksView: View {
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  
  var body: some View {
    VStack {
      // Title
      Text("My Bookmarks")
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding(.top, 15)
        .padding(.leading, 20)
      
      
      // Debugging
//      Text("\(filterPostsByUserId(posts: postRepository.posts, userId: userRepository.users[0].id).count)")
//      Text("\(postRepository.posts.count)")
//      Text(postRepository.posts[0].userId)
      
      
      // Posts with logged in userId
      ScrollView {
        ForEach(getUserBookmarks(bookmarks: userRepository.users[0].Bookmarks, posts: postRepository.posts), id: \.id) { post in
          MyPostCardView(post: post, postRepository: postRepository, userRepository: userRepository)
        }
      }
    }
  }
  
  func getUserBookmarks(bookmarks: [String], posts: [Post]) -> [Post] {
      // Filter the posts array where userId matches the given userId string
    return posts.filter { bookmarks.contains($0.id) }
  }

}

//
//  MyBookmarksView.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/12/3.
//

