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
        VStack {
           AlbumView(musicItem: exampleShazamMusicItem)

            MusicInfoRow(musicItem: exampleShazamMusicItem)
        }
    }
}

#Preview {
    @Previewable @StateObject var permissionViewModel = PermissionViewModel()
    HomeView()
        .environmentObject(permissionViewModel)
}
