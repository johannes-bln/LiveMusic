//
//  MusicInfoRow.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 31.10.25.
//

import SwiftUI

struct MusicInfoRow: View {
    let musicItem: ShazamMusicItem
    var body: some View {
        VStack {
            Text(musicItem.title ?? String(localized: "MusicInfoRow - Title", defaultValue: "Title"))
                .accessibilityLabel(
                    "\(String(localized: "MusicInfoRow - Title", defaultValue: "Title")): \(musicItem.title ?? String(localized: "MusicInfoRow - unknown", defaultValue: "unknown"))"
                ) // Title: Some Title ?? unknown
                .fontType(.title)

            Text(musicItem.artist ?? String(localized: "MusicInfoRow - Artist", defaultValue: "Artist"))
                .accessibilityLabel(
                    "\(String(localized: "MusicInfoRow - Artist", defaultValue: "Artist")): \(musicItem.artist ?? String(localized: "MusicInfoRow - unknown", defaultValue: "unknown"))"
                ) // Title: Some Artist ?? unknown
                .fontType(.artist)
        }
    }
}

#Preview {
    MusicInfoRow(musicItem: exampleShazamMusicItem)
}
