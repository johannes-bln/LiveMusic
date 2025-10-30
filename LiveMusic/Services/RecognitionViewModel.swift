//
//  RecognitionViewModel.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import Foundation
import Combine

@MainActor
class RecognitionViewModel: ObservableObject {
    @Published var isRecognizing: Bool = false
}
