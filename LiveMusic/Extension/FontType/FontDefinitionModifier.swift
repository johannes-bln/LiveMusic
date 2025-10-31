//
//  FontDefinitionModifier.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 31.10.25.
//

import SwiftUI

enum FontType {
    case title
    case artist
    case album
}

struct FontDefinitionModifier: ViewModifier {
    let fontType: FontType
    func body(content: Content) -> some View {
        switch fontType {
        case .title:
            content
                .bold()
        case .artist:
            content
                .bold()
                .foregroundStyle(.gray)
        case .album:
            content
        }
    }
}
