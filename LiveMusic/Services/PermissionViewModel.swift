//
//  PermissionViewModel.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import Foundation
import Combine

@MainActor
class PermissionViewModel: ObservableObject {
    @Published var allowsMicrophoneAccess: Bool = false
    @Published var allowsAppleMusicAccess: Bool = false
    // Add methods to request permissions
}
