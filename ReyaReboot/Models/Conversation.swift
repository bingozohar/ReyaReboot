//
//  Conversation.swift
//  ReyaMLX
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import Foundation
import SwiftData

@Model
class Conversation: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    var persona: Persona
    var timestamp: Date
    
    @Relationship(deleteRule: .cascade)
    var messages: [Message] = []
    
    init(timestamp: Date = Date.now, persona: Persona) {
        self.timestamp = timestamp
        self.messages = [
            .system(persona.prompt)
        ]
        self.persona = persona
    }
}

extension Conversation {
    var sortedMessages: [Message] {
        return messages.sorted { $0.timestamp < $1.timestamp }
    }
}
