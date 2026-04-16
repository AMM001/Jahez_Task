//
//  TrendingMoviesApp.swift
//  TrendingMovies
//
//  Created by vodafone on 12/04/2026.
//

import SwiftUI
import SwiftData
import MoviesSPM
import Combine
import NetworkLayerSPM


@main
struct TrendingMoviesApp: App {

    // ✅ Shared SwiftData container
    private let sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([
            CachedMovie.self,
            CachedMovieDetails.self
        ])

        do {
            sharedModelContainer = try ModelContainer(for: schema)
        } catch {
            fatalError("❌ Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MoviesModule.makeMoviesListView()
        }
        .modelContainer(sharedModelContainer) // ✅ inject once
    }
}
