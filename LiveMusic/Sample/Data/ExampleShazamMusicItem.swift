//
//  ExampleShazamMusicItem.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 31.10.25.
//

import Foundation

let exampleShazamMusicItem = ShazamMusicItem(
    id: UUID(),
    title: "Example Song",
    subtitle: "Example Album (Deluxe)",
    artist: "Example Artist",
    artworkURL: URL(string: "https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=1200&q=80"),
    videoURL: URL(string: "https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=1600&q=80"),
    genres: ["Pop", "Electronic"],
    explicitContent: false,
    creationDate: ISO8601DateFormatter().date(from: "2024-11-15T10:30:00Z"),
    isrc: "EXEX12400001",
    appleMusicURL: URL(string: "https://music.apple.com/us/album/example-song/1234567890?i=1234567891"),
    appleMusicID: "1234567891",
    webURL: URL(string: "https://www.shazam.com/track/123456789/example-song"),
    shazamID: "123456789",
    recognizedAt: Date(),
    recognizedAtLocationLatitude: 55.520008,
    recognizedAtLocationLongitude: 11.404954
)

let demoExampleShazamMusicItems: [ShazamMusicItem] = [
    .init(
        id: UUID(),
        title: "Example Song",
        subtitle: "Live in Berlin",
        artist: "Example Artist",
        artworkURL: URL(string: "https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=1200&q=80"),
        videoURL: URL(string: "https://images.unsplash.com/photo-1511192336575-5a79af67a629?w=1600&q=80"),
        genres: ["Pop"],
        explicitContent: false,
        creationDate: ISO8601DateFormatter().date(from: "2024-10-01T09:00:00Z"),
        isrc: "EXEX12400002",
        appleMusicURL: URL(string: "https://music.apple.com/us/album/example-song/1234567890?i=1234567892"),
        appleMusicID: "1234567892",
        webURL: URL(string: "https://www.shazam.com/track/123456790/example-song-live"),
        shazamID: "123456790",
        recognizedAt: Date().addingTimeInterval(-3600),
        recognizedAtLocationLatitude: 52.515,
        recognizedAtLocationLongitude: 14.39
    ),
    .init(
        id: UUID(),
        title: "Chill Example Track",
        subtitle: "Lofi Session",
        artist: "Unknown Example",
        artworkURL: URL(string: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=1200&q=80"),
        videoURL: nil,
        genres: ["Lofi", "Beats"],
        explicitContent: false,
        creationDate: ISO8601DateFormatter().date(from: "2023-06-12T12:00:00Z"),
        isrc: "EXEX12300003",
        appleMusicURL: URL(string: "https://music.apple.com/us/album/chill-example-track/9876543210?i=9876543211"),
        appleMusicID: "9876543211",
        webURL: URL(string: "https://www.shazam.com/track/987654321/chill-example-track"),
        shazamID: "987654321",
        recognizedAt: Date().addingTimeInterval(-7200),
        recognizedAtLocationLatitude: 55.53,
        recognizedAtLocationLongitude: 9.41
    )
]
