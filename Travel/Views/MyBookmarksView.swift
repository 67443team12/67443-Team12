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
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack(spacing: 16) {
      // Custom back button and title
      HStack {
        Button(action: {
          presentationMode.wrappedValue.dismiss() // Dismiss the view
        }) {
          Image(systemName: "chevron.left")
            .font(.title2.bold())
            .foregroundColor(.accentColor)
        }
        .padding(.leading, 10)
        
        Spacer()
        
        Text("My Bookmarks")
          .font(.title2)
          .fontWeight(.bold)
          .padding(.trailing, 25)
        
        Spacer()
      }
      .frame(maxWidth: .infinity) // Ensure the title centers properly
      .padding(.top, 10)
      .padding(.horizontal, 10)
      .navigationBarBackButtonHidden(true) // Hide default back button
      
      // Posts with logged-in userId
      ScrollView {
        ForEach(getUserBookmarks(bookmarks: userRepository.users[0].Bookmarks, posts: postRepository.posts), id: \.id) { post in
          MyPostCardView(post: post, postRepository: postRepository, userRepository: userRepository)
        }
      }
    }
    .navigationBarHidden(true) // Hide the default navigation bar if needed
    .background(Color("Cream"))
  }
  
  func getUserBookmarks(bookmarks: [String], posts: [Post]) -> [Post] {
    // Filter the posts array where the post ID matches any in the bookmarks array
    return posts.filter { bookmarks.contains($0.id) }
  }
}
