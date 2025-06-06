//
//  MessageView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI
import MarkdownUI

struct MessageView: View {
    let message: Message
    
    init(_ message: Message) {
        self.message = message
    }
    
    private var color: Color {
        switch message.role {
        case .user:
            return .mint
        case .assistant:
            return .purple
        default:
            return .gray
        }
    }
    
    private var edge: Edge {
        switch message.role {
        case .user:
            return .trailing
        default:
            return .leading
        }
    }
    
    var body: some View {
        switch message.role {
        case .user:
            HStack {
                Spacer()
                Rectangle().fill(
                    Color.mint
                )
                .frame(width: 2)
                Markdown(message.content)
                    .textSelection(.enabled)
                    .padding(10)
            }
        case .assistant:
            HStack {
                Markdown(message.content)
                    .textSelection(.enabled)
                    .padding(10)
                Rectangle().fill(
                    Color.purple)
                .frame(width: 2)
                Spacer()
            }
        case .system:
            Label(message.content, systemImage: "desktopcomputer")
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    VStack() {
        MessageView(.system("You are a helpful assistant."))
        MessageView(.user("Question"))
        MessageView(.assistant("Answer"))
    }
}
