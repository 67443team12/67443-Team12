//
//  SelfPost.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct SelfPost: Identifiable, Codable, Comparable {
	var id: String
	var title: String
	var postTime: String
	var content: String
	var ifBookmarked: Bool
	
	enum CodingKeys: String, CodingKey {
		case id = "postId"
		case title
		case postTime
		case content
		case ifBookmarked
	}
	
	static func < (lhs: SelfPost, rhs: SelfPost) -> Bool {
		lhs.postTime < rhs.postTime
	}
	
	static func == (lhs: SelfPost, rhs: SelfPost) -> Bool {
		lhs.id == rhs.id
	}
	
	static let example = SelfPost(
		id: "5MT4E8",
		title: "I LOVE New York",
		postTime: "2024-10-22T03:15:14.557Z",
		content: "I had the most amazing evening walking along the riverside in New York. Make sure to check out Brooklyn Bridge Park, the High Line, Central Park, and Battery Park!",
		ifBookmarked: false
	)
	
}
