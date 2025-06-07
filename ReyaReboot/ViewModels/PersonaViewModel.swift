//
//  PersonaViewModel.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 07/06/2025.
//

import Foundation

@Observable
class PersonaViewModel {
    private let dataSource: PersonaDataSource
    
    init(with dataSource: PersonaDataSource) {
        self.dataSource = dataSource
    }
    
    var personas: [Persona] {
        return dataSource.fetch()
    }
}
