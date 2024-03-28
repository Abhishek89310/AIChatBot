//
//  MessengerView.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import SwiftUI


struct MessengerView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var scrollToBottom = false

    var body: some View {
        VStack {
                  ScrollViewReader { scrollView in
                      ScrollView {
                          VStack(spacing: 10) {
                              ForEach(viewModel.messages) { message in
                                  MessageView(message: message)
                              }
                          }
                          .onChange(of: viewModel.messages) { _ in
                              scrollToBottom = true
                          }
                          .onAppear {
                              scrollToBottom = true
                          }
                          .onReceive(viewModel.$messages) { _ in
                              if scrollToBottom {
                                  withAnimation {
                                      scrollView.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                                  }
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

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isFromUser: Bool

    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}

#Preview {
    MessengerView(viewModel: ChatViewModel())
}
