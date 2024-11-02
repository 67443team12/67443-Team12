//
//  SimpleUser.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import Foundation
import SwiftUI

struct SimpleUser: Codable, Identifiable, Comparable {
	var id: String
	var name: String
	var photo: String
	
	enum CodingKeys: String, CodingKey {
		case id = "userId"
		case name
		case photo
	}
	
	static func < (lhs: SimpleUser, rhs: SimpleUser) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: SimpleUser, rhs: SimpleUser) -> Bool {
		lhs.id == rhs.id
	}
}
