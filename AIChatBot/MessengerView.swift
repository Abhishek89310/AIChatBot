//
//  MessengerView.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import SwiftUI
import GoogleGenerativeAI

struct MessengerView: View {
    @State private var userInput = ""
    @State private var messages: [Message] = []

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages) { message in
                    HStack {
                        if message.isFromUser {
                            Spacer()
                            Text(message.text)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        } else {
                            Text(message.text)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            Spacer()
                        }
                    }
                }
            }

            HStack {
                TextField("Type a message...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: sendMessage) {
                    Text("Send")
                }
            }.padding()
        }
    }

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

    func generateAIResponse(to userMessage: String) async -> String {
        let model = GenerativeModel(name: "gemini-pro", apiKey: "your-api")
        do {
            let response = try await model.generateContent(userMessage)
            return response.text ?? "No text generated"
        } catch {
            return "Error generating content: \(error)"
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}

#Preview {
    MessengerView()
}
