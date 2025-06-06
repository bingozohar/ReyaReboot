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
    
    
    init(type: Role, content: String, timestamp: Date = .now) {
        self.role = type
        self.content = content
        self.timestamp = timestamp
    }
}
