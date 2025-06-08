//
//  Untitled.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 07/06/2025.
//

import SwiftUI

struct PersonaSelectorSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var personaViewModel: PersonaViewModel
    
    private let action: (Persona) -> Void
    
    private var personas: [Persona] = []

    init(personaViewModel: PersonaViewModel, action: @escaping (Persona) -> Void) {
        self.personaViewModel = personaViewModel
        self.action = action
        
        personas = personaViewModel.personas
    }
    
    var body: some View {
        NavigationStack {
            HStack() {
                ForEach(personas, id: \.self.id) { persona in
                    VStack() {
                        Text(persona.id)
                        Text(persona.details)
                        Button("Choose") {
                            action(persona)
                            dismiss()
                        }
                    }
                    
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 10)
        }
        //.navigationTitle(Text("Persona Selector"))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}
