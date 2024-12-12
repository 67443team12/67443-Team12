//
//  FriendsRowView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

// View for displaying a single row representing a friend in the friends list
struct FriendsRowView: View {
  var friend: User
  
  var body: some View {
    HStack(spacing: 20) {
      // Image loader for the friend's profile picture
      AsyncImage(url: URL(string: friend.photo)) { image in
        image.resizable()
      } placeholder: {
        Circle()
          .fill(Color.gray)
          .overlay(Text(friend.name.prefix(1)))
      }
      .frame(width: 50, height: 50)
      .clipShape(Circle())
      
      // Display the friend's name
      Text(friend.name)
    }
  }
}
