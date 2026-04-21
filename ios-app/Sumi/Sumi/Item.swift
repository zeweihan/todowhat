//
//  Item.swift
//  Sumi
//
//  Created by Zewei Han on 16/4/2026.
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
