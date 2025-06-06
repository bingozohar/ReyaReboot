//
//  ConversationItem.swift
//  ReyaMLX
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import Foundation
import SwiftData

@Model
class Message: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    
    @Relationship
    var conversation: Conversation?
    
    var role: Role
    var content: String
    var timestamp: Date

    init(role: Role, content: String, timestamp: Date = .now) {
        self.role = role
        self.content = content
        self.timestamp = timestamp
    }
}

extension Message {
    static func user(_ content: String) -> Message {
        Message(role: .user, content: content)
    }
    
    static func assistant(_ content: String) -> Message {
        Message(role: .assistant, content: content)
    }
    
    static func system(_ content: String) -> Message {
        Message(role: .system, content: content)
    }
}
