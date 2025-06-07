//
//  ConversationDataSource.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 07/06/2025.
//

import Foundation
import SwiftData

@MainActor
class ConversationDataSource {
    //private let container: ModelContainer?
    private let context: ModelContext?
    
    init(_ context: ModelContext?) {
        //self.container = container
        self.context = context
    }
}

extension ConversationDataSource {
    func insert(_ entity: Conversation) {
        context?.insert(entity)
    }
    
    func delete(_ entity: Conversation) {
        context?.delete(entity)
    }
    
    func load(forPersona persona: Persona) -> Conversation? {
        let fetchDescriptor = FetchDescriptor<Conversation>(
            predicate: #Predicate { conversation in conversation.persona.id == persona.id},
            sortBy: [SortDescriptor(\.timestamp)]
        )
        let conversations = try? context?.fetch(fetchDescriptor)
        return conversations?.last
    }
    
    func fetch() -> [Conversation] {
        let fetchDescriptor = FetchDescriptor<Conversation>(
            sortBy: [SortDescriptor(\.timestamp)])
        let conversations = try? context?.fetch(fetchDescriptor)
        return conversations ?? []
    }
}
