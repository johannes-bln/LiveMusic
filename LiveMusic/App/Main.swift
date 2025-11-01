//
//  Main.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import SwiftData
import SwiftUI

@main
struct Main: App {
    @StateObject private var permissionsViewModel = PermissionViewModel()
    private let container: ModelContainer

    init() {
        let bundleID =
            Bundle.main.bundleIdentifier ?? "de.johannes-bln.LiveMusic"

        let schema = Schema([
            ShazamMusicItem.self
        ])

        let config = ModelConfiguration(
            "ShazamData",
            cloudKitDatabase: .private(bundleID)
        )

        debugPrint("Using iCloud Container ID: \(bundleID)")

        do {
            container = try ModelContainer(
                for: schema,
                configurations: [config]
            )
        } catch {
            debugPrint(error)
            fatalError(error.localizedDescription)
        }
    }

    var body: some Scene {
        WindowGroup {
            #if DEBUG
                HomeViewDebug()
                    .environmentObject(permissionsViewModel)
            #else
                HomeView()
                    .environmentObject(permissionsViewModel)
            #endif
        }
        .modelContainer(container)
    }
}
