//
//  LMModel.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//

import MLX
import MLXLLM
import MLXVLM
import MLXLMCommon

/// Represents a language model configuration with its associated properties and type.
/// Can represent either a large language model (LLM) or a vision-language model (VLM).
struct LMModel {
    /// Name of the model
    let name: String

    /// Configuration settings for model initialization
    let configuration: ModelConfiguration

    /// Type of the model (language or vision-language)
    let type: ModelType
    
    let provider: ProviderType
    
    /// Defines the type of language model
    enum ModelType {
        /// Large language model (text-only)
        case llm
        /// Vision-language model (supports images and text)
        case vlm
    }
    
    enum ProviderType {
        case mlx
        case ollama
    }
}

// MARK: - Helpers

extension LMModel {
    /// Display name with additional "(Vision)" suffix for vision models
    var displayName: String {
        if isVisionModel {
            "\(name) (Vision)"
        } else {
            name
        }
    }

    /// Whether the model is a large language model
    var isLanguageModel: Bool {
        type == .llm
    }

    /// Whether the model is a vision-language model
    var isVisionModel: Bool {
        type == .vlm
    }
}

extension LMModel: Identifiable, Hashable {
    var id: String {
        name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension LMModel {
    static let availableModels: [String: LMModel] = [
        "mistral:7b": LMModel(
            name: "mistral:7b",
            configuration: LLMRegistry.mistral7B4bit,
            type: .llm,
            provider: .mlx
        ),
        "llama3.2:3b": LMModel(
            name: "llama3.2:3b",
            configuration: LLMRegistry.llama3_2_3B_4bit,
            type: .llm,
            provider: .mlx
        ),
        "gemma3:4b": LMModel(
            name: "gemma3:4b",
            configuration: ModelConfiguration(id: "gemma3:4b"),
            type: .llm,
            provider: .ollama
        )
    ]
}
