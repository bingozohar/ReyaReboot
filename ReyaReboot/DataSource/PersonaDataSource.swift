//
//  PersonaDataSource.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 07/06/2025.
//

import Foundation

class PersonaDataSource {
    
}

extension PersonaDataSource {
    func fetch() -> [Persona] {
        let personas = decode("personas.json")
        return personas
    }
}

fileprivate extension PersonaDataSource {
    private func decode(_ file: String) -> [Persona] {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Faliled to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedFile = try? decoder.decode([Persona].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loadedFile
    }
}
