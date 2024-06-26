//
//  AIChatBotApp.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import SwiftUI
import SwiftData

@main
struct AIChatBotApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            let model = ChatViewModel()
            MessengerView(viewModel: model)
        }
        .modelContainer(sharedModelContainer)
    }
}
