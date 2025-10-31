//
//  HomeViewDebug.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import SwiftUI

struct HomeViewDebug: View {
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @State private var showNormalView = false

    var body: some View {
        VStack {
            Text("Welcome to LiveMusic DEBUG!")
                .font(.largeTitle)
                .padding()

            Text(
                permissionViewModel.allowsMicrophoneAccess
                    ? "Mic Granted" : "Mic Not Granted"
            )

            Text(
                permissionViewModel.allowsAppleMusicAccess
                    ? "Apple Music Granted" : "Apple Music Not Granted"
            )

            Text(
                permissionViewModel.allowsNotifications
                    ? "Notifications Granted" : "Notifications Not Granted"
            )

            Text(
                permissionViewModel.allowsLiveActivities
                    ? "Live Activities Granted" : "Live Activities Not Granted"
            )

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

            Button("1. location permission") {
                Task {
                    permissionViewModel.requestLocationAccessWhenInUse()
                }
            }

            Button("2. location permission always (request first the normal location!!!)") {
                Task {
                    permissionViewModel.requestLocationAccessAlways()
                }
            }

            Button("App Settings iOS") {
                permissionViewModel.navigateToSettings()
            }

            Button("Launch **LiveMusic**") {
                showNormalView = true
            }

            AlbumView(musicItem: exampleShazamMusicItem)

            MusicInfoRow(musicItem: exampleShazamMusicItem)

        }
        .padding()
        .fullScreenCover(isPresented: $showNormalView) {
            HomeView()
        }
    }
}

#Preview {
    @Previewable @StateObject var permissionViewModel = PermissionViewModel()
    HomeViewDebug()
        .environmentObject(permissionViewModel)
}
