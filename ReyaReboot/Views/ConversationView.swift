//
//  ConversationView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI

struct ConversationView: View {
    var messages : [Message]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(messages) { message in
                    MessageView(message)
                        .id(message.id)
                        .padding(.horizontal, 12)
                }
            }
            .defaultScrollAnchor(.bottom, for: .sizeChanges)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    do {
        ConversationView(
            messages: [
                .system("You are a helpful assistant."),
                .user("Question"),
                .assistant("Answer")
            ]
        )
    }
}
