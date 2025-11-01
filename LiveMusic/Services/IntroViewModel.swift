//
//  IntroViewModel.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 01.11.25.
//

import SwiftUI
import Combine
import Foundation

enum IntroPresentedView {
    case intro
    case permissionMicrophone
    case permissionLocation
    case permissionLocationAlways
    case home
}

@MainActor
class IntroViewModel: ObservableObject {
    @Published var presentedView: IntroPresentedView = .intro

    @AppStorage("app_has_intro_shown") var hasIntroShown: Bool = false

    func navigateToPermissionMicrophone() {
        presentedView = .permissionMicrophone
    }

    func navigateToPermissionLocation() {
        presentedView = .permissionLocation
    }

    func navigateToPermissionLocationAlways() {
        presentedView = .permissionLocationAlways
    }

    func navigateToHome() {
        presentedView = .home
    }
}
