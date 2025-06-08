//
//  OllamaService.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 07/06/2025.
//

//
//  MLXService.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import Foundation
import OllamaKit
import Defaults

@Observable
class OllamaService {
    var ollamaKit: OllamaKit
    
    init() {
        let baseURL = Defaults[.host]!
        self.ollamaKit = OllamaKit(baseURL: baseURL)
    }
    
    func generate(messages: [Message], model: LMModel) -> AsyncThrowingStream<OKChatResponse, Error> {
        let data = Message.toOKChatRequestData(messages: messages, model: model.name)
        return ollamaKit.chat(data: data)
    }
}
