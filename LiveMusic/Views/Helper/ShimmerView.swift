//
//  ShimmerView.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 01.11.25.
//

import SwiftUI

struct ShimmerView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {

                Color.secondary.opacity(0.12)
                Image(systemName: "music.note")
                    .font(.system(size: 32))
                    .foregroundStyle(.secondary)
            }
            .overlay(

                LinearGradient(
                    colors: [
                        .white.opacity(0),
                        .white.opacity(0.5),
                        .white.opacity(0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .rotationEffect(.degrees(20))
                .frame(width: geometry.size.width * 2)  // 2x width
                .offset(x: phase - geometry.size.width)  // start at -width
                .blendMode(.plusLighter)
                .mask(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)  // white mask shape
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height
                        )
                )
            )
            .onAppear {
                // Start phase at 0 (offset = -width), then animate to 2*width
                phase = 0
                withAnimation(
                    .linear(duration: 1.2).repeatForever(autoreverses: false)
                ) {
                    phase = geometry.size.width * 2
                }
            }
        }
    }
}
