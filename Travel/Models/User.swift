//
//  User.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable, Comparable {
	var id: String
	var name: String
	var photo: String
	var Posts: [SelfPost]
	var Bookmarks: [Post]
	var Trips: [String]
	var Friends: [SimpleUser]
	var Requests: [SimpleUser]
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case photo
		case Posts
		case Bookmarks
		case Trips
		case Friends
		case Requests
	}
	
	static func < (lhs: User, rhs: User) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: User, rhs: User) -> Bool {
		lhs.id == rhs.id
	}
	
	static let example = User(
		id: "Alice215",
		name: "Alice",
		photo: "",
		Posts: [SelfPost.example],
		Bookmarks: [Post.example],
		Trips: ["269C753NIQ"],
		Friends: [SimpleUser.bob],
		Requests: [SimpleUser.clara]
	)
}