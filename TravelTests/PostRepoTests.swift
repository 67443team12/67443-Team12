//
//  PostRepoTests.swift
//  Travel
//
//  Created by k mao on 12/6/24.
//

import XCTest
@testable import Travel
import Combine

class PostRepositoryTests: XCTestCase {
  
  var postRepository: PostRepository!
  var cancellables: Set<AnyCancellable>!

  override func setUp() {
    super.setUp()
    postRepository = PostRepository()
    cancellables = []
  }

  override func tearDown() {
    postRepository = nil
    cancellables = nil
    super.tearDown()
  }
  
  // Test if posts are fetched correctly
  func testGetPosts() {
    let expectation = self.expectation(description: "Fetching posts")
    
    // Simulate that posts are fetched
    postRepository.$posts
      .dropFirst()
      .sink { posts in
        XCTAssertGreaterThan(posts.count, 0, "Posts should be fetched")
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    // Trigger fetching posts
    postRepository.get()

    waitForExpectations(timeout: 2.0, handler: nil)
  }
  
  // Test if a post is added correctly
  func testAddPost() {
    let newPost = Post(
      id: "test123",
      title: "New Post",
      time: "2024-12-06",
      content: "This is a new post",
      userId: "testUser",
      userName: "Test User",
      userPhoto: "testPhoto",
      ifBookmarked: false,
      comments: [],
      photo: "testPhotoURL"
    )
    
    let expectation = self.expectation(description: "Adding post")
    
    // Simulate adding the post
    postRepository.$posts
      .dropFirst()
      .sink { posts in
        XCTAssertEqual(posts.first?.id, newPost.id, "New post should be added")
        expectation.fulfill()
      }
      .store(in: &cancellables)
    
    // Add the post
    postRepository.addPost(newPost)

    waitForExpectations(timeout: 2.0, handler: nil)
  }

  // Test if a post's bookmark status is toggled
  func testToggleBookmark() {
    var post = Post.example1
    let initialBookmarkStatus = post.ifBookmarked

    postRepository.toggleBookmark(for: post)

    XCTAssertNotEqual(post.ifBookmarked, initialBookmarkStatus, "Post bookmark status should toggle")
  }

  // Test if a comment is added to a post
  func testAddComment() {
    var post = Post.example1
    let comment = Comment(id: "1", userId: "Great post!", userName: "testUser", userPhoto: "Test User", content: "testPhoto")
    
    postRepository.addComment(to: post, comment: comment)

    XCTAssertEqual(post.comments.count, 1, "Comment should be added to post")
    XCTAssertEqual(post.comments.first?.content, comment.content, "Comment text should match")
  }

  // Test upload photo completion with a valid image
  func testUploadPhoto() {
    let image = UIImage(systemName: "star")!  // Placeholder image
    
    let expectation = self.expectation(description: "Uploading photo")
    
    postRepository.uploadPhoto(image) { url in
      XCTAssertNotNil(url, "URL should be returned after uploading image")
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5.0, handler: nil)
  }

}
