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
        HStack(alignment: .center) {
            if (message.role == .assistant) {
                Spacer()
                Rectangle().fill(
                    Color.mint
                )
                .frame(width: 2)
            }
            Markdown(message.content)
                .textSelection(.enabled)
                .padding(10)
            
            if (message.role == .user) {
                Rectangle().fill(
                    Color.purple)
                .frame(width: 2)
                Spacer()
            }
        }
        .padding(5)
    }
}

#Preview {
    VStack() {
        MessageView(.init(type: .user, content: "Question"))
        MessageView(.init(type: .assistant, content: "Answer"))
    }
}
