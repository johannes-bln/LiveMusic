//
//  Main.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import SwiftUI

@main
struct Main: App {
    @StateObject var permissionsViewModel = PermissionViewModel()

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
    }
}
