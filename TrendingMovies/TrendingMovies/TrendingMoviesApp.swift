//
//  TrendingMoviesApp.swift
//  TrendingMovies
//
//  Created by vodafone on 12/04/2026.
//

import SwiftUI
import SwiftData
import NetworkLayer_SPM
import Movies_SPM

@main
struct TrendingMoviesApp: App {
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
    
        }
        .modelContainer(sharedModelContainer)
    }
}
