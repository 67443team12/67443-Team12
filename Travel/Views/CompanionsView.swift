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
		VStack {
			VStack {
				ForEach(people) { person in
					CompanionRowView(person: person)
				}
			}
			.padding(.vertical)
			NavigationLink(destination: SelectFriendsView()) {
				ZStack {
					Rectangle()
						.fill(Color("LightPurple"))
						.frame(height: 70)
					HStack() {
						Text("Invite More Friends")
							.padding(.leading, 30)
							.fontWeight(.semibold)
						Spacer()
						Image(systemName: "arrow.right")
							.fontWeight(.semibold)
							.padding(.trailing, 30)
					}
					.foregroundStyle(.black)
				}
			}
			Spacer()
		}
		.navigationTitle("Companions")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	CompanionsView(people: [SimpleUser.bob, SimpleUser.clara])
}
