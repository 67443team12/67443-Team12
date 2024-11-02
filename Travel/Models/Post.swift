//
//  Post.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

class Post: Identifiable, Codable, Comparable {
	var id: String
	var title: String
	var postTime: String
	var content: String
	var userId: String
	var userName: String
	var userphoto: String
	var ifBookmarked: Bool
	
	enum CodingKeys: String, CodingKey {
		case id = "postId"
		case title
		case postTime
		case content
		case userId
		case userName
		case userphoto
		case ifBookmarked
	}
	
	static func < (lhs: Post, rhs: Post) -> Bool {
		lhs.postTime < rhs.postTime
	}
	
	static func == (lhs: Post, rhs: Post) -> Bool {
		lhs.id == rhs.id
	}
}
