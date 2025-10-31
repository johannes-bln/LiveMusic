//
//  View+Extension.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 30.10.25.
//

import SwiftUI

extension View {
    func fontType(_ fontType: FontType) -> some View {
        modifier(FontDefinitionModifier(fontType: fontType))
    }
}
