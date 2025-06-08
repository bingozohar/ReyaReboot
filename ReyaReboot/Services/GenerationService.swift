//
//  GenerationService.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 08/06/2025.
//

import Foundation
import OllamaKit
import MLX
import MLXLLM
import MLXVLM
import MLXLMCommon

protocol GenerationService {
    associatedtype StreamType
    func generate(messages: [Message], model: LMModel) -> StreamType
}

// MARK: - Wrapper pour unifier les types de retour
enum GenerationResult {
    case ollamaChunk(OKChatResponse)
    case mlxGeneration(Generation)
}

// MARK: - Service unifié
class UnifiedGenerationService {
    private let ollamaService = OllamaService()
    private let mlxService = MLXService()
    
    func generate(
        messages: [Message], 
        model: LMModel, 
        useOllama: Bool
    ) -> AsyncThrowingStream<GenerationResult, Error> {
        return AsyncThrowingStream { continuation in
            Task {
                do {
                    if useOllama {
                        print("GENERATION PAR OLLAMA")
                        for try await chunk in ollamaService.generate(messages: messages, model: model) {
                            continuation.yield(.ollamaChunk(chunk))
                        }
                    } else {
                        print("GENERATION PAR MLX")
                        for await generation in try await mlxService.generate(messages: messages, model: model) {
                            continuation.yield(.mlxGeneration(generation))
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
