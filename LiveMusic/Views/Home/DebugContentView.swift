//
//  HomeViewDebug.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//
import Observation
internal import ShazamKit
import SwiftData
import SwiftUI

struct HomeViewDebug: View {
    @EnvironmentObject var permissionViewModel: PermissionViewModel
    @State private var showNormalView = false
    @State private var showHistorySheet = false

    @StateObject private var viewModel: ShazamMusicItemsViewModel
    @StateObject private var recognizer: ShazamRecognizer
    private let injectedContext: ModelContext

    @Query(sort: \ShazamMusicItem.recognizedAt, order: .reverse)
    private var items: [ShazamMusicItem]

    private struct LatestItemView: View {
        @Bindable var item: ShazamMusicItem
        var body: some View {
            VStack {
                AlbumView(musicItem: item)
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .accessibilityLabel("Album Cover Art")
                MusicInfoRow(musicItem: item)
            }
        }
    }

    init(context: ModelContext) {
        self.injectedContext = context
        let shazamMusicItemnsViewModel = ShazamMusicItemsViewModel(context: context)
        _viewModel = StateObject(wrappedValue: shazamMusicItemnsViewModel)
        _recognizer = StateObject(wrappedValue: ShazamRecognizer(viewModel: shazamMusicItemnsViewModel))
    }

    var body: some View {
        TabView {
            // MARK: - Playground
            playgroundView()
                .tabItem {
                    Label("Playground", systemImage: "hammer")
                }
                .task {
                    do {
                        if recognizer.isListening {
                            recognizer.stopListening()
                        } else {
                            try await recognizer.startListening()
                        }
                    } catch {
                        debugPrint(error)
                    }
                }

            // MARK: - Permissions
            permissionView()
                .tabItem {
                    Label("Permissions", systemImage: "lock.shield")
                }
        }
        .modelContext(injectedContext)
        .fullScreenCover(isPresented: $showNormalView) {
            HomeView()
        }
        // Sheet für History
        .sheet(isPresented: $showHistorySheet) {
            ShazamHistorySheet(items: items)
                .presentationDetents([.medium, .large])
        }
    }

    @ViewBuilder
    func playgroundView() -> some View {
        VStack {
            if let latest = recognizer.latestShazamMusicItem {
                LatestItemView(item: latest)
                    .id(latest.persistentModelID)
            } else {
                VStack {
                    AlbumView(musicItem: exampleShazamMusicItem)
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    MusicInfoRow(musicItem: exampleShazamMusicItem)
                }
            }

            Button(recognizer.isListening ? "Stop" : "Listen") {
                Task {
                    if recognizer.isListening {
                        recognizer.stopListening()
                    } else {
                        try? await recognizer.startListening()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)

            Button("Show Shazam History") {
                showHistorySheet = true
            }
            .buttonStyle(.bordered)
            .padding(.top)
        }
        .animation(.default, value: recognizer.latestShazamMusicItem)
    }

    @ViewBuilder
    func permissionView() -> some View {
        VStack(spacing: 12) {
            Text("Welcome to LiveMusic DEBUG!")
                .font(.largeTitle)
                .padding()

            Text(permissionViewModel.allowsMicrophoneAccess ? "Mic Granted" : "Mic Not Granted")
            Text(permissionViewModel.allowsAppleMusicAccess ? "Apple Music Granted" : "Apple Music Not Granted")
            Text(permissionViewModel.allowsNotifications ? "Notifications Granted" : "Notifications Not Granted")
            Text(permissionViewModel.allowsLiveActivities ? "Live Activities Granted" : "Live Activities Not Granted")

            Button("apple music permission") { Task { await permissionViewModel.requestAppleMusicPermission() } }
            Button("mic permission") { Task { await permissionViewModel.requestMicrophonePermission() } }
            Button("notifications") { Task { await permissionViewModel.requestNotificationPermission() } }
            Button("1. location permission") { Task { permissionViewModel.requestLocationAccessWhenInUse() } }
            Button("2. location permission always (request first normal one!)") { Task { permissionViewModel.requestLocationAccessAlways() } }
            Button("App Settings iOS") { permissionViewModel.navigateToSettings() }
            Button("Launch **LiveMusic**") { showNormalView = true }
        }
    }
}
import MapKit
// MARK: - Sheet mit allen gespeicherten Shazams
private struct ShazamHistorySheet: View {
    let items: [ShazamMusicItem]

    var body: some View {
        NavigationStack {
            List(items) { item in
                HStack(spacing: 12) {
                    AsyncImage(url: item.artworkURL) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        default:
                            Color.secondary.opacity(0.1)
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                        }
                    }

                    NavigationLink {
                        Map {
                            Marker("ITEM", coordinate: CLLocationCoordinate2D(
                                latitude: item.recognizedAtLocationLatitude ?? 0,
                                longitude: item.recognizedAtLocationLongitude ?? 0
                            ))
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title ?? "Unknown Title")
                                .font(.headline)
                            Text(item.artist ?? "")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(item.recognizedAt, style: .time)
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                            if let latitude = item.recognizedAtLocationLatitude, let longitude = item.recognizedAtLocationLongitude {
                                Text("Lat: \(latitude), Lon: \(longitude)")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }

                }
            }
            .navigationTitle("All Shazams")
        }
    }
}
