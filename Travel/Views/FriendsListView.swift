////
////  FriendsListView.swift
////  Travel
////
////  Created by Emma Shi on 11/24/24.
////
//
//import SwiftUI
//
//struct FriendsListView: View {
//	@EnvironmentObject var aliceVM: MockUser
//	@State private var searchText: String = ""
//	
//	var filteredFriends: [SimpleUser] {
//		if searchText.isEmpty {
//			return aliceVM.user.Friends
//		} else {
//			return aliceVM.user.Friends.filter {
//				$0.name.localizedCaseInsensitiveContains(searchText)
//			}
//		}
//	}
//	
//	var body: some View {
//		NavigationView {
//			VStack {
//				HStack {
//					Text("Friends")
//						.font(.largeTitle)
//						.fontWeight(.bold)
//						.padding(.top, 15)
//						.padding(.leading, 20)
//					Spacer()
//					NavigationLink(destination: AddFriendView()) {
//						Image(systemName: "person.badge.plus")
//							.font(.largeTitle)
//							.padding(.top, 15)
//							.padding(.trailing, 20)
//					}
//					// if user's request list is not empty show red dot
//					.overlay {
//						if !aliceVM.user.Requests.isEmpty {
//							Image(systemName: "circle.fill")
//								.foregroundColor(Color.red)
//								.font(.caption2)
//								.padding([.leading, .bottom])
//						}
//					}
//				}
//				HStack {
//					TextField("Search friend", text: $searchText)
//						.padding(.leading, 10) // Extra padding for text
//						.padding(.vertical, 15)
//					
//					if !searchText.isEmpty {
//						Button(action: {
//							searchText = ""
//						}) {
//							Image(systemName: "xmark.circle.fill")
//								.foregroundColor(.gray)
//						}
//						.padding(.trailing, 10)
//					}
//				}
//				.background(Color(.systemGray5))
//				.cornerRadius(10)
//				.padding(.horizontal, 20)
//				.padding(.bottom, 10)
//				List {
//					if filteredFriends.isEmpty {
//						Text("No friends match your search.")
//							.foregroundColor(.gray)
//					} else {
//						ForEach(filteredFriends, id: \.id) { friend in
//							ZStack(alignment: .leading) {
//								FriendsRowView(friend: friend)
//								NavigationLink(destination: FriendProfileView()) {
//									EmptyView()
//								}
//								.opacity(0)
//							}
//						}
//					}
//				}
//				.listStyle(PlainListStyle())
//			}
//		}
//	}
//}
//
//#Preview {
//	FriendsListView()
//		.environmentObject(MockUser(user: User.example))
//}
