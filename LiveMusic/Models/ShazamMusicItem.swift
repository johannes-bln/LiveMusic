//
//  ShazamMusicItem.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import Foundation
import SwiftData

@Model
class ShazamMusicItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String?
    var subtitle: String?
    var artist: String?
    var artworkURL: URL?
    var videoURL: URL?
    var genres: [String]
    var explicitContent: Bool
    var creationDate: Date?
    var isrc: String?

    var appleMusicURL: URL?
    var appleMusicID: String?

    var webURL: URL?
    var shazamID: String?

    var recognizedAt: Date

    var recognizedAtLocationLatitude: Double?
    var recognizedAtLocationLongitude: Double?

    init(
        id: UUID,
        title: String? = nil,
        subtitle: String? = nil,
        artist: String? = nil,
        artworkURL: URL? = nil,
        videoURL: URL? = nil,
        genres: [String],
        explicitContent: Bool,
        creationDate: Date? = nil,
        isrc: String? = nil,
        appleMusicURL: URL? = nil,
        appleMusicID: String? = nil,
        webURL: URL? = nil,
        shazamID: String? = nil,
        recognizedAt: Date,
        recognizedAtLocationLatitude: Double? = nil,
        recognizedAtLocationLongitude: Double? = nil) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.artist = artist
        self.artworkURL = artworkURL
        self.videoURL = videoURL
        self.genres = genres
        self.explicitContent = explicitContent
        self.creationDate = creationDate
        self.isrc = isrc
        self.appleMusicURL = appleMusicURL
        self.appleMusicID = appleMusicID
        self.webURL = webURL
        self.shazamID = shazamID
        self.recognizedAt = recognizedAt
        self.recognizedAtLocationLatitude = recognizedAtLocationLatitude
        self.recognizedAtLocationLongitude = recognizedAtLocationLongitude
    }
}
