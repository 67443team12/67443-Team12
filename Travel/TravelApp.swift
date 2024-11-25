//
//  TravelApp.swift
//  Travel
//
//  Created by Cindy Jiang on 2024/10/29.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TravelApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
      WindowGroup {
				SplashView()
      }
    }
}
