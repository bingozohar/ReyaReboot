//
//  ReyaMLXApp.swift
//  ReyaMLX
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI
import SwiftData

@main
struct ReyaRebootApp: App {
    let container: ModelContainer
    
    @State private var chatViewModel: ChatViewModel
    @State private var personaViewModel: PersonaViewModel
    
    var body: some Scene {
        Window("", id: "mlx-reya-local-ia") {
            ChatView(
                chatViewModel: chatViewModel,
                personaViewModel: personaViewModel
            )
                //.environment(chatViewModel)
                //.environment(personaViewModel)
        }
    }
    
    init() {
        do {
            let schema = Schema([Conversation.self, Message.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
        
        chatViewModel = ChatViewModel(
            with: ConversationDataSource(container.mainContext),
            andService: MLXService()
        )
        
        personaViewModel = PersonaViewModel(
            with: PersonaDataSource()
        )
        
        let lastConversation = chatViewModel.conversations.last
        
        let personaToUse = lastConversation?.persona ?? personaViewModel.personas.first
        chatViewModel.selectPersona(persona: personaToUse!)
    }
    
    /*var container: ModelContainer = {
        let schema = Schema([
            Conversation.self,
            Message.self
        ])
        

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()*/
}


