//
//  PermissionViewModel.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import AVFoundation
import UserNotifications
import ActivityKit
import MusicKit
import Combine
import UIKit

@MainActor
final class PermissionViewModel: ObservableObject {
    @Published var allowsMicrophoneAccess = false
    @Published var allowsAppleMusicAccess = false
    @Published var allowsNotifications = false
    @Published var allowsLiveActivities = false

    init() {
        Task { await refreshPermissions() }
    }

    // MARK: - Microphone Permission
    func requestMicrophonePermission() async {
        let granted = await AVCaptureDevice.requestAccess(for: .audio)
        allowsMicrophoneAccess = granted
    }

    // MARK: - Apple Music Permission
    func requestAppleMusicPermission() async {
        let status = await MusicAuthorization.request()
        allowsAppleMusicAccess = status == .authorized
    }

    // MARK: - Notification Permission
    func requestNotificationPermission() async {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        do {
            let granted = try await center.requestAuthorization(options: options)
            if granted {
                print("Notifications permission granted.")
            } else {
                print("Notifications permission denied.")
            }
        } catch {
            print("Error requesting notifications permission: \(error)")
        }
    }

    // MARK: - Request Live Activity Permission
    func requestLiveActivityPermission() async {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            print("Live Activities are enabled.")
        } else {
            print("Live Activities are not enabled.")
        }
    }

    // MARK: - Refresh Permissions
    func refreshPermissions() async {
        let micStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        allowsMicrophoneAccess = micStatus == .authorized

        let musicStatus = MusicAuthorization.currentStatus
        allowsAppleMusicAccess = musicStatus == .authorized

        let notiStatus = await UNUserNotificationCenter.current().notificationSettings()
        allowsNotifications = notiStatus.authorizationStatus == .authorized

        if ActivityAuthorizationInfo().areActivitiesEnabled {
            print("Live Activities are enabled.")
            allowsLiveActivities = true
        } else {
            print("Live Activities are not enabled.")
            allowsLiveActivities = false
        }
    }

    // MARK: - Navigate to Settings
    func navigateToSettings() {
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings)
        }
    }
}
