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
	var time: String
	var content: String
	var ifBookmarked: Bool
//  var photos: [Photo]
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case time
		case content
		case ifBookmarked
//    case photos
	}
	
	static func < (lhs: SelfPost, rhs: SelfPost) -> Bool {
		lhs.time < rhs.time
	}
	
	static func == (lhs: SelfPost, rhs: SelfPost) -> Bool {
		lhs.id == rhs.id
	}
	
	static let example = SelfPost(
		id: "5MT4E8",
		title: "I LOVE New York",
		time: "2024-10-22T03:15:14.557Z",
		content: "I had the most amazing evening walking along the riverside in New York. Make sure to check out Brooklyn Bridge Park, the High Line, Central Park, and Battery Park!",
		ifBookmarked: false
//    photos: []
	)
}
