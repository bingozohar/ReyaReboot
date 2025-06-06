//
//  WritePromptView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI

struct WritePromptView: View {
    @Binding var prompt: String
    var status: ReyaStatus
    var sendMessage: () -> Void
    
    var body: some View {
        HStack {
            TextField("Write your message here", text: $prompt, axis: .vertical)
                .padding()
                .onSubmit {
                    sendMessage()
                }
            
            Button(action: sendMessage) {
                if status == .busy {
                    ProgressView()
                        .scaleEffect(0.4)
                } else {
                    Image(systemName: "arrowtriangle.up.fill")
                        .foregroundStyle(.mint)
                        .imageScale(.large)
                        .fontWeight(.bold)
                }
            }
            .controlSize(.large)
            .clipShape(.circle)
            .overlay {
                Circle().stroke(.mint, lineWidth: 2)
            }
            .disabled(prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                      || status != .ready)
        }
    }
}

#Preview {
    WritePromptView(
        prompt: .constant("Test du prompt"),
        status: .ready) {
            
        }
    
    WritePromptView(
        prompt: .constant("Test du prompt"),
        status: .busy) {
            
        }
}
