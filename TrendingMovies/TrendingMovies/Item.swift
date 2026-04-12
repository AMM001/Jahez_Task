//
//  Item.swift
//  TrendingMovies
//
//  Created by vodafone on 12/04/2026.
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
