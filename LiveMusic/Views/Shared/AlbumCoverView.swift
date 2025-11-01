//
//  AlbumView.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import Foundation
import SwiftUI

struct AlbumView: View {
    let musicItem: ShazamMusicItem
    var body: some View {
        if let imageURL = musicItem.artworkURL {
            AsyncImage(
                url: imageURL,
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    placeholder()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .transition(.opacity)
                case .failure:
                    errorView
                @unknown default:
                    errorView
                }
            }
        }
    }

    private func placeholder() -> some View {
        ShimmerView()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var errorView: some View {
        ZStack {
            Color.secondary.opacity(0.1)
            Image(systemName: "exclamationmark.triangle")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    AlbumView(musicItem: exampleShazamMusicItem)
}
