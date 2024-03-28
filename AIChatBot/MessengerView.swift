//
//  MessengerView.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import SwiftUI


struct MessengerView: View {
    @ObservedObject var viewModel: ChatViewModel

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
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
                TextField("Type a message...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: viewModel.sendMessage) {
                    Text("Send")
                }
            }.padding()
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}

#Preview {
    MessengerView(viewModel: ChatViewModel())
}
