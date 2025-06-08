//
//  ChatView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    //@Environment(\.modelContext) var modelContext
    @State private var chatViewModel : ChatViewModel
    @State private var personaViewModel: PersonaViewModel
    @State private var showingPersonaSelector = false
    
    init(chatViewModel: ChatViewModel, personaViewModel: PersonaViewModel) {
        self.chatViewModel = chatViewModel
        self.personaViewModel = personaViewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ConversationView(messages: chatViewModel.conversation!.sortedMessages)
                
                Divider()
                
                WritePromptView(
                    prompt: $chatViewModel.prompt,
                    status: chatViewModel.status,
                    sendButtonAction: chatViewModel.generate
                )
                //.border(width: 2, edges: [.top], color: .mint)
            }
            .navigationTitle(chatViewModel.conversation!.persona.id)
            .toolbar {
                ChatToolbarView(vm: chatViewModel, showPersonSelector: $showingPersonaSelector)
            }
            .sheet(isPresented: $showingPersonaSelector) {
                PersonaSelectorSheet(personaViewModel: personaViewModel) { persona in
                    chatViewModel.selectPersona(persona: persona)
                }
            }
            .toolbarBackground(
                            LinearGradient(
                                colors: [.purple, .mint, .purple],
                                startPoint: .topLeading,
                                endPoint: .trailing
                            )
                        )
            .padding()
        }
    }
}
