//
//  CompanionsView.swift
//  Travel
//
//  Created by Emma Shi on 11/2/24.
//

import SwiftUI

struct CompanionsView: View {
	var people: [SimpleUser]
	
	var body: some View {
		List {
			ForEach(people) { person in
				Text(person.name)
			}
		}
	}
}

#Preview {
	CompanionsView(people: [SimpleUser.bob])
}
