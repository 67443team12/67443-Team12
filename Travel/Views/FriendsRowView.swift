//
//  FriendsRowView.swift
//  Travel
//
//  Created by Emma Shi on 11/24/24.
//

import SwiftUI

struct FriendsRowView: View {
	var friend: User
	var body: some View {
		HStack(spacing: 20) {
			AsyncImage(url: URL(string: friend.photo)) { image in
				image.resizable()
			} placeholder: {
				Circle()
					.fill(Color.gray)
					.overlay(Text(friend.name.prefix(1)))
			}
			.frame(width: 50, height: 50)
			.clipShape(Circle())
			
			Text(friend.name)
		}
	}
}
