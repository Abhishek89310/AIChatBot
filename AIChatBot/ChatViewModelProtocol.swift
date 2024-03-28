//
//  ChatViewModelProtocol.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import Foundation

protocol ChatViewModelProtocol: ObservableObject {
    var userInput: String { get set }
    var messages: [Message] { get }
    func sendMessage()
}
