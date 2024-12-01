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
		Bookmarks: [Post.example1],
		Trips: ["73C54CB4-40FC-41DC-88FA-154CA48D429E",
					 "C32EC717-A11F-4540-8B00-EA3099252331",
					 "206907B8-7CDA-42BB-849B-A6B3E5145623"],
		Friends: [SimpleUser.bob, SimpleUser.leia, SimpleUser.luke],
		Requests: [SimpleUser.clara]
	)
}
