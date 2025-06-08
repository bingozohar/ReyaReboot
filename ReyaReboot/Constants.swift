//
//  Constants.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 07/06/2025.
//

import Foundation
import Defaults

extension Defaults.Keys {
    static let useOllama = Key<Bool>("useOllama", default: false)
    static let defaultTemperature = Key<Double>("defaultTemperature", default: 0.7)
    static let defaultTopP = Key<Double>("defaultTopP", default: 0.9)
    static let defaultTopK = Key<Int>("defaultTopK", default: 40)
    static let host = Key<URL?>("host", default: URL(string:"http://localhost:11434"))
}
