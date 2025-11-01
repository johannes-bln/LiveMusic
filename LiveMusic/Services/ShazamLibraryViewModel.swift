//
//  ShazamLibraryViewModel.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import Foundation
import Combine
import SwiftData

@MainActor
final class ShazamMusicItemsViewModel: ObservableObject {
    @Published private(set) var items: [ShazamMusicItem] = []
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        load()
    }

    func load() {
        let descriptor = FetchDescriptor<ShazamMusicItem>(
            sortBy: [SortDescriptor(\.recognizedAt, order: .reverse)]
        )
        do {
            items = try context.fetch(descriptor)
        } catch {
            items = []
            debugPrint("Fetch error:", error)
        }
    }

    func add(_ item: ShazamMusicItem) {
        context.insert(item)
        load()
    }

    func delete(_ item: ShazamMusicItem) {
        context.delete(item)
        load()
    }
}
