//
//  ChatToolbarView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI

/// Toolbar view for the chat interface that displays error messages, download progress,
/// generation statistics, and model selection controls.
struct ChatToolbarView: View {
    /// View model containing the chat state and controls
    @Bindable var vm: ChatViewModel
    @Binding var showPersonSelector: Bool

    var body: some View {
        // Display error message if present
        if let errorMessage = vm.errorMessage {
            ErrorView(errorMessage: errorMessage)
        }
        
        PersonaInfoView(
            persona: vm.conversation!.persona,
        )

        // Show download progress for model loading
        if let progress = vm.modelDownloadProgress, !progress.isFinished {
            DownloadProgressView(progress: progress)
        }

        Button {
            showPersonSelector.toggle()
        } label: {
            Text("Persona")
        }
        
        // Button to clear chat history, displays generation statistics
        Button {
            vm.clear([.chat])
        } label: {
            Text("Clear")
        }
    }
}
