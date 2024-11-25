//
//  Post.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct Post: Identifiable, Codable, Comparable {
	var id: String
	var title: String
	var time: String
	var content: String
	var userId: String
	var userName: String
	var userPhoto: String
	var ifBookmarked: Bool
  var photos: [String]
//  var comments: [Comment]
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case time
		case content
		case userId
		case userName
		case userPhoto
		case ifBookmarked
		case photos
//		case comments
	}
	
	static func < (lhs: Post, rhs: Post) -> Bool {
		lhs.time < rhs.time
	}
	
	static func == (lhs: Post, rhs: Post) -> Bool {
		lhs.id == rhs.id
	}
	
	static let example = Post(
		id: "35FNRV",
		title: "Pittsburgh Adventures",
		time: "2024-10-16T12:24:14.557Z",
		content: "So nice to see Pittsburgh transformed into a city advocated for innovation and education! The visit to the Duquesne Incline was fantastic!",
		userId: "Bob1241",
		userName: "Bob",
		userPhoto: "",
		ifBookmarked: true,
    photos: []
//    comments: []
	)
}
