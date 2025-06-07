//
//  PersonaInfoView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import SwiftUI
import MarkdownUI
import ViewCondition

struct PersonaInfoView: View {
    var persona: Persona
    
    var body: some View {
        HStack() {
            Text(persona.details)
                .fontWeight(.bold)
            Text("(" + persona.model + ")")
        }
    }
}


#Preview {
    PersonaInfoView(
        persona: Persona(id: "Reya", description: "Powerfull Assistant", prompt: "PROMPT", model: "MODEL"),
    )
}

