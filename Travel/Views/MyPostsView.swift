
import SwiftUI

struct MyPostsView: View {
  @ObservedObject var postRepository: PostRepository
  @ObservedObject var userRepository: UserRepository
  
  var body: some View {
    VStack {
      // Title
      Text("My Posts")
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
        ForEach(filterPostsByUserId(posts: postRepository.posts, userId: userRepository.users[0].id), id: \.id) { post in
          MyPostCardView(post: post, postRepository: postRepository, userRepository: userRepository)
        }
      }
    }
  }
  
  func filterPostsByUserId(posts: [Post], userId: String) -> [Post] {
      // Filter the posts array where userId matches the given userId string
      return posts.filter { $0.userId == userId }
  }

}

