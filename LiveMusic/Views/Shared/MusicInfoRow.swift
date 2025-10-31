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
            Text(musicItem.title ?? String(localized: "placeholder.title", defaultValue: "Title"))
                .accessibilityLabel(
                    "\(String(localized: "static.title.accessibility", defaultValue: "Title")): \(musicItem.title ?? String(localized: "placeholder.title.accessibility", defaultValue: "unknown"))"
                )
                .fontType(.title)

            Text(musicItem.artist ?? String(localized: "placeholder.artist", defaultValue: "Artist"))
                .accessibilityLabel(
                    "\(String(localized: "static.artist.accessibility", defaultValue: "Artist")): \(musicItem.artist ?? String(localized: "placeholder.artist.accessibility", defaultValue: "unknown"))"
                )
                .fontType(.artist)
        }
    }
}

#Preview {
    MusicInfoRow(musicItem: exampleShazamMusicItem)
}
