//
//  ConversationItem.swift
//  ReyaMLX
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import Foundation
import SwiftData
import OllamaKit
import Defaults

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

extension Message {
    static func toOKChatRequestData(messages: [Message], model: String) -> OKChatRequestData {
        var requestMessages = [OKChatRequestData.Message]()
        
        for message in messages {
            let role: OKChatRequestData.Message.Role =
            switch message.role {
            case .assistant:
                    .assistant
            case .user:
                    .user
            case .system:
                    .system
            }
            let chatMessage = OKChatRequestData.Message(role: role, content: message.content)
            requestMessages.append(chatMessage)
        }
        
        let options = OKCompletionOptions(
            temperature: Defaults[.defaultTemperature],
            topK: Defaults[.defaultTopK],
            topP: Defaults[.defaultTopP]
        )
        
        var data = OKChatRequestData(model: model, messages: requestMessages)
        data.options = options
        
        return data
    }
}
