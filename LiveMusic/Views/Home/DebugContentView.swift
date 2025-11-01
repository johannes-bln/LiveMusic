//
//  HomeViewDebug.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//  FIXME: - THIS IS ONLY A DEBUG VIEW; IT MUST NOT BE FOLLOW CODE STYLES. it is a playground :)

import SwiftUI

struct HomeViewDebug: View {
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @State private var showNormalView = false

    var body: some View {
        TabView {

            // MARK: - Permissions Tab
            VStack {
                    
                List {
                    Button {
                        permissionViewModel.requestLocationAccessWhenInUse()
                    } label: {
                        permissionRow(
                            title: "Location When In Use",
                            granted: permissionViewModel.allowsLocationAccessWhenInUse
                        )
                    }
                    
                    Button {
                        permissionViewModel.requestLocationAccessAlways()
                    } label: {
                        permissionRow(
                            title: "Location Always",
                            granted: permissionViewModel.allowsLocationAccessAlways
                        )
                    }
                }
                
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
            }
            .tabItem {
                Label("Permissions", systemImage: "lock.shield")
            }

            // MARK: - Playground of the Main View
            VStack {
                AlbumView(musicItem: exampleShazamMusicItem)
                MusicInfoRow(musicItem: exampleShazamMusicItem)
            }
            .tabItem {
                Label("Playground", systemImage: "hammer")
            }
        }
        .fullScreenCover(isPresented: $showNormalView) {
            HomeView()
        }
    }

    @ViewBuilder
    func permissionRow(title: String, granted: Bool) -> some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: granted ? "checkmark.circle.fill" : "x.circle.fill")
                .foregroundColor(granted ? .green : .red)
        }
        .padding()
    }
}

#Preview {
    @Previewable @StateObject var permissionViewModel = PermissionViewModel()
    HomeViewDebug()
        .environmentObject(permissionViewModel)
}
