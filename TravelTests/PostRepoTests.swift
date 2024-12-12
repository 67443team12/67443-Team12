//
//  PostRepoTests.swift
//  Travel
//
//  Created by Kailan Mao on 12/6/24.
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
    var hasFulfilled = false
    postRepository.$posts
      .dropFirst()
      .sink { posts in
        if !hasFulfilled {
          XCTAssertNotNil(posts, "Posts should not be nil")
          XCTAssertGreaterThan(posts.count, 0, "Posts array should contain elements")
          hasFulfilled = true
          expectation.fulfill()
        }
      }
      .store(in: &cancellables)
    postRepository.get()
    waitForExpectations(timeout: 5.0, handler: nil)
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
    postRepository.$posts
      .dropFirst()
      .sink { posts in
        XCTAssertEqual(posts.first?.id, newPost.id, "New post should be added")
        expectation.fulfill()
      }
      .store(in: &cancellables)
    postRepository.addPost(newPost)
    waitForExpectations(timeout: 2.0, handler: nil)
  }

  // Test if a post's bookmark status is toggled
  func testToggleBookmark() {
    let post = Post.example1
    let initialBookmarkStatus = post.ifBookmarked
    postRepository.toggleBookmark(for: post)
    postRepository.$posts
      .dropFirst()
      .sink { posts in
        let updatedPost = posts.first(where: { $0.id == post.id })
        XCTAssertNotEqual(updatedPost?.ifBookmarked, initialBookmarkStatus, "Post bookmark status should toggle")
      }
      .store(in: &cancellables)
    }

  // Test if a comment is added to a post
  func testAddComment() {
    let post = Post.example1
    let comment = Comment(id: "1", userId: "testUser", userName: "Test User", userPhoto: "testPhoto", content: "Great post!")
    postRepository.addComment(to: post, comment: comment)
    postRepository.$posts
      .dropFirst()
      .sink { posts in
        let updatedPost = posts.first(where: { $0.id == post.id })
        XCTAssertEqual(updatedPost?.comments.count, 1, "Comment should be added to post")
        XCTAssertEqual(updatedPost?.comments.first?.content, comment.content, "Comment text should match")
      }
      .store(in: &cancellables)
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
