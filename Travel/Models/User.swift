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
	var Posts: [String]
	var Bookmarks: [String]
	var Trips: [String]
	var Friends: [String]
	var Requests: [String]
	
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
	
	//	static let example = User(
	//		id: "Alice215",
	//		name: "Alice",
	//		photo: "https://firebasestorage.googleapis.com/v0/b/cmu443team12.firebasestorage.app/o/alice-icon.png?alt=media&token=1b8e454a-cec1-4433-a441-2f4d7085898d",
	//		Posts: [SelfPost.example],
	//		Bookmarks: [Post.example],
	//		Trips: ["73C54CB4-40FC-41DC-88FA-154CA48D429E",
	//					 "C32EC717-A11F-4540-8B00-EA3099252331",
	//					 "206907B8-7CDA-42BB-849B-A6B3E5145623"],
	//		Friends: [SimpleUser.bob, SimpleUser.leia, SimpleUser.luke],
	//		Requests: [SimpleUser.clara]
	//	)
	//	
	//	static let bob = User(
	//		id: "Bob1241",
	//		name: "Bob",
	//		photo: "",
	//		Posts: [],
	//		Bookmarks: [],
	//		Trips: ["73C54CB4-40FC-41DC-88FA-154CA48D429E",
	//						"C32EC717-A11F-4540-8B00-EA3099252331"],
	//		Friends: [SimpleUser.alice],
	//		Requests: []
	//	)
	
	func toDictionary() -> [String: Any] {
		return [
			"id": id,
			"name": name,
			"photo": photo,
			"Posts": Posts,
			"Bookmarks": Bookmarks,
			"Trips": Trips,
			"Friends": Friends,
			"Requests": Requests
		]
	}
	
}
