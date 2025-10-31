//
//  debugPrint.swift
//  LiveMusic
//
//  Created by Johannes Glückler on 31.10.25.
//

import Foundation

public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    // swiftlint:disable:next no_print
    Swift.print(items.map { "\($0)" }.joined(separator: separator), terminator: terminator)
    #endif
}
