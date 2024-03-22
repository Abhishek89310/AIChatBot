//
//  Item.swift
//  AIChatBot
//
//  Created by Matrix on 22/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
