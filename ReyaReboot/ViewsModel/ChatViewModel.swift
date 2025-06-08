//
//  ChatViewModel.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import Foundation
import SwiftData
import SwiftUI
import Defaults

@Observable
@MainActor
class ChatViewModel {
    private let useOllama: Bool = Defaults[.useOllama]
    private let dataSource: ConversationDataSource
    //private var modelContext: ModelContext
    
    /// Service responsible for ML model operations
    private let mlxService: MLXService
    
    /// Current user input text
    var prompt: String = ""
    
    var conversation: Conversation? = nil
    
    /// Currently selected language model for generation
    //var selectedModel: LMModel = MLXService.availableModels.first!
    
    var selectedModel: LMModel {
        //let model: LMModel = MLXService.availableModels["mistral:7b"]!
        if let modelName = conversation?.persona.model {
            
            let model: LMModel = LMModel.availableModels[modelName]!
            return model
        }
        return LMModel.availableModels.first!.value
    }
    /// Indicates if text generation is in progress
    var status: Status = .ready
    
    /// Current generation task, used for cancellation
    private var generateTask: Task<Void, any Error>?
    /// Progress of the current model download, if any
    var modelDownloadProgress: Progress? {
        mlxService.modelDownloadProgress
    }
    
    /// Most recent error message, if any
    var errorMessage: String?
    
    init(with dataSource: ConversationDataSource, andService mlxService: MLXService) {
        //self.modelContext = modelContext
        self.dataSource = dataSource
        self.mlxService = mlxService
    }
    
    func selectPersona(persona: Persona) {
        var conversation = dataSource.load(forPersona: persona)
        
        if conversation == nil {
            conversation = Conversation(persona: persona)
            dataSource.insert(conversation!)
        }
        self.conversation = conversation
    }
    
    /// Generates response for the current prompt and media attachments
    func generate() async {
        // Cancel any existing generation task
        if let existingTask = generateTask {
            existingTask.cancel()
            generateTask = nil
        }

        status = .busy

        // Add user message with any media attachments
        //messages.append(.user(prompt, images: mediaSelection.images, videos: mediaSelection.videos))
        conversation!.messages.append(.user(prompt))
        // Add empty assistant message that will be filled during generation
        conversation!.messages.append(.assistant(""))

        // Clear the input after sending
        clear(.prompt)

        generateTask = Task {
            do {
                let unifiedService = UnifiedGenerationService()
                
                for try await result in unifiedService.generate(
                    messages: conversation!.sortedMessages,
                    model: selectedModel,
                    useOllama: selectedModel.provider == .ollama
                ) {
                    handleGenerationResult(result)
                }
                /*if useOllama {
                    let ollamaService = OllamaService()
                    for try await chunk in ollamaService.generate(messages: conversation!.sortedMessages, model: selectedModel) {
                        if let assistantMessage = conversation!.sortedMessages.last {
                            assistantMessage.content += chunk.message?.content ?? ""
                        }
                    }
                }
                else {
                    // Process generation chunks and update UI
                    for await generation in try await mlxService.generate(
                        messages: conversation!.sortedMessages, model: selectedModel)
                    {
                        switch generation {
                        case .chunk(let chunk):
                            // Append new text to the current assistant message
                            if let assistantMessage = conversation!.sortedMessages.last {
                                assistantMessage.content += chunk
                            }
                        case .info(let info):
                            // Update performance metrics
                            //generateCompletionInfo = info
                            print(" INFO: ", info)
                        }
                    }
                }*/
            } catch {
                errorMessage = error.localizedDescription
            }
            status = .ready
        }

        do {
            // Handle task completion and cancellation
            try await withTaskCancellationHandler {
                try await generateTask?.value
            } onCancel: {
                Task { @MainActor in
                    generateTask?.cancel()

                    // Mark message as cancelled
                    if let assistantMessage = conversation!.messages.last {
                        assistantMessage.content += "\n[Cancelled]"
                    }
                }
            }
        } catch {
            print(" ERROR: ", error)
            errorMessage = error.localizedDescription
        }
        generateTask = nil
    }
    
    @MainActor
    private func handleGenerationResult(_ result: GenerationResult) {
        guard let assistantMessage = conversation!.sortedMessages.last else { return }
        
        switch result {
        case .ollamaChunk(let chunk):
            assistantMessage.content += chunk.message?.content ?? ""
            
        case .mlxGeneration(let generation):
            switch generation {
            case .chunk(let chunk):
                assistantMessage.content += chunk
            case .info(let info):
                print("INFO: ", info)
            }
        }
    }
    
    // Clears various aspects of the chat state based on provided options
    func clear(_ options: ClearOption) {
        if options.contains(.prompt) {
            prompt = ""
            //mediaSelection = .init()
        }

        if options.contains(.chat) {
            conversation!.messages = [
                .system(conversation!.persona.prompt)
            ]
            generateTask?.cancel()
        }
        errorMessage = nil
    }
}

extension ChatViewModel {
    var conversations: [Conversation] {
        return dataSource.fetch()
    }
}

/// Options for clearing different aspects of the chat state
struct ClearOption: RawRepresentable, OptionSet {
    let rawValue: Int

    /// Clears current prompt and media selection
    static let prompt = ClearOption(rawValue: 1 << 0)
    /// Clears chat history and cancels generation
    static let chat = ClearOption(rawValue: 1 << 1)
    /// Clears generation metadata
    static let meta = ClearOption(rawValue: 1 << 2)
}

enum Status: String, Codable {
    case ready
    case busy
}
