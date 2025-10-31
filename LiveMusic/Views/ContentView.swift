//
//  ContentView.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var permissionViewModel: PermissionViewModel

    var body: some View {
        VStack {
            Text("Welcome to LiveMusic!")
                .font(.largeTitle)
                .padding()

            Text(permissionViewModel.allowsMicrophoneAccess ? "Mic Granted" : "Mic Not Granted")

            Text(permissionViewModel.allowsAppleMusicAccess ? "Apple Music Granted" : "Apple Music Not Granted")

            Text(permissionViewModel.allowsNotifications ? "Notifications Granted" : "Notifications Not Granted")

            Text(permissionViewModel.allowsLiveActivities ? "Live Activities Granted" : "Live Activities Not Granted")

            Button("apple music permission") {
                Task {
                    await permissionViewModel.requestAppleMusicPermission()
                }
            }
            Button("mic permission") {
                Task {
                    await permissionViewModel.requestMicrophonePermission()
                }
            }

            Button("notifications") {
                Task {
                    await permissionViewModel.requestNotificationPermission()
                }
            }

            Button("App Settings iOS") {
                permissionViewModel.navigateToSettings()
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
