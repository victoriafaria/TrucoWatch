//
//  TrucoWatchApp.swift
//  TrucoWatch WatchKit Extension
//
//  Created by Victoria Faria on 27/08/20.
//

import SwiftUI

@main
struct TrucoWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
