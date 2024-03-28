//
//  ChatViewModel.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import Foundation
import GoogleGenerativeAI

class ChatViewModel: ChatViewModelProtocol {
    @Published var userInput: String = ""
    @Published var messages: [Message] = []

    func sendMessage() {
        let userMessage = Message(text: userInput, isFromUser: true)
        messages.append(userMessage)

        userInput = ""

        Task {
            let aiResponseText = await generateAIResponse(to: userMessage.text)
            let aiMessage = Message(text: aiResponseText, isFromUser: false)
            messages.append(aiMessage)
        }
    }

    private func generateAIResponse(to userMessage: String) async -> String {
        let model = GenerativeModel(name: "gemini-pro", apiKey: "api_key")
        do {
            let response = try await model.generateContent(userMessage)
            return response.text ?? "No text generated"
        } catch {
            return "Error generating content: \(error)"
        }
    }
}
