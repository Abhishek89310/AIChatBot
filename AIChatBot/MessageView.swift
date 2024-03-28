//
//  MessageView.swift
//  AIChatBot
//
//  Created by Matrix on 28/03/24.
//

import SwiftUI

struct MessageView: View {
    let message: Message

        var body: some View {
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


