//
//  ReyaMLXApp.swift
//  ReyaMLX
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI
import SwiftData

@main
struct ReyaMLXApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Conversation.self,
            Message.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ChatView()
        }
        .modelContainer(sharedModelContainer)
    }
}

enum ReyaStatus: String, Codable {
    case ready
    case busy
}
