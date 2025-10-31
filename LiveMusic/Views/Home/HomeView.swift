//
//  HomeView.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var permissionViewModel: PermissionViewModel

    var body: some View {
        NavigationStack {
            Text("Home comes here later")
        }
    }
}

#Preview {
    @Previewable @StateObject var permissionViewModel = PermissionViewModel()
    HomeView()
        .environmentObject(permissionViewModel)
}
