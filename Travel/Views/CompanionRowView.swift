//
//  CompanionRowView.swift
//  Travel
//
//  Created by Emma Shi on 11/3/24.
//

import SwiftUI

struct CompanionRowView: View {
	var person: SimpleUser
	
	var body: some View {
		HStack(spacing: 20) {
			Circle()
				.fill(.blue)
				.frame(width: 50, height: 50)
			Text(person.name)
				.font(.title3)
				.fontWeight(.semibold)
			Spacer()
			Button(action: {}) {
				Text("Remove")
					.padding(12)
					.background(Color("LightPurple"))
					.foregroundColor(Color.black)
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}
		}
		.padding(.horizontal, 30)
	}
}

#Preview {
	CompanionRowView(person: SimpleUser.bob)
}
