//
//  ShazamRecognizer.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 01.11.25.
//

import AVFAudio
import Combine
import Foundation
internal import ShazamKit
internal import _LocationEssentials
import UserNotifications

@MainActor
final class ShazamRecognizer: NSObject, ObservableObject, SHSessionDelegate {
    private var session: SHSession?
    private let audioEngine = AVAudioEngine()
    private weak var viewModel: ShazamMusicItemsViewModel?
    private let locationProvider = OneShotLocationProvider()

    @Published private(set) var currentMatch: SHMatchedMediaItem?
    @Published private(set) var recentMatches: [SHMatchedMediaItem] = []
    @Published private(set) var isListening = false
    @Published private(set) var latestShazamMusicItem: ShazamMusicItem?

    private var lastMatchedTitle: String?
    private var lastMatchTime: Date?

    // MARK: - Init
    init(viewModel: ShazamMusicItemsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Start Listening
    func startListening() async throws {
        guard !isListening else { return }
        isListening = true

        session = SHSession()
        session?.delegate = self

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }

        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 2048, format: format) { [weak self] buffer, time in
            self?.session?.matchStreamingBuffer(buffer, at: time)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }

    // MARK: - Stop Listening
    func stopListening() {
        guard isListening else { return }
        isListening = false
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        session = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    // MARK: - Delegate
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let item = match.mediaItems.first else { return }

        let now = Date()
        if item.title == recentMatches.first?.title {
            return // einfache Deduplikation
        }

        Task { @MainActor in

            let loc = await locationProvider.fetchOnceIfAuthorized()

            currentMatch = item
            recentMatches.insert(item, at: 0)
            lastMatchedTitle = item.title
            lastMatchTime = now

            let model = ShazamMusicItem(
                title: item.title,
                subtitle: item.subtitle,
                artist: item.artist,
                artworkURL: item.artworkURL,
                videoURL: item.videoURL,
                genres: item.genres,
                explicitContent: item.explicitContent,
                creationDate: item.creationDate,
                isrc: item.isrc,
                appleMusicURL: item.appleMusicURL,
                appleMusicID: item.appleMusicID,
                webURL: item.webURL,
                shazamID: item.shazamID,
                recognizedAt: now,
                recognizedAtLocationLatitude: loc?.coordinate.latitude,
                recognizedAtLocationLongitude: loc?.coordinate.longitude
            )
            viewModel?.add(model)
            latestShazamMusicItem = model
            let content = UNMutableNotificationContent()
            content.title = "🎵 Song erkannt"
            content.body = "\(item.title ?? "Unbekannt") – \(item.artist ?? "Unbekannter Künstler")"
            content.sound = .default

            // let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil) // DYNAMIC
            let request = UNNotificationRequest(identifier: "shazam_recognition", content: content, trigger: nil) // STATIC
            do {
                try await UNUserNotificationCenter.current().add(request)
            } catch {
                debugPrint("Notification error:", error)
            }
            debugPrint("Recognized:", item.title ?? "Unknown Title")
        }
    }

    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        // Kein Treffer – ShazamKit läuft einfach weiter
    }
}
