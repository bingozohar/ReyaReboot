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
    
    var model: String
    var persona: Persona
    var timestamp: Date
    
    @Relationship(deleteRule: .cascade)
    var items: [Message] = []
    
    init(timestamp: Date = Date.now, model: String, persona: Persona) {
        self.timestamp = timestamp
        self.model = model
        self.items = []
        self.persona = persona
    }
}

extension Conversation {
    var sortedItems: [Message] {
        return items.sorted { $0.timestamp < $1.timestamp }
    }
}
