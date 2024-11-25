//
//  SplashView.swift
//  Travel
//
//  Created by Emma Shi on 11/21/24.
//

import SwiftUI

struct SplashView: View {
	@State var isActive: Bool = false
	
	var body: some View {
		ZStack {
			if self.isActive {
				ContentView()
			} else {
				Color("LightPurple")
					.ignoresSafeArea()
				Text("TogetherTrip")
					.font(Font.custom("Lobster", size: 48))
					.fontWeight(.bold)
			}
		}.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
				withAnimation {
					self.isActive = true
				}
			}
		}
	}
}

#Preview {
	SplashView()
}
