//
//  File.swift
//  MoviesSPM
//
//  Created by vodafone on 16/04/2026.
//

import Foundation
import SwiftData
import NetworkLayerSPM

@MainActor
public final class MoviesSwiftDataCache {
    
    private let context: ModelContext
    
    public init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Movies list
    
    public func fetchMovies() -> [Movie] {
        let descriptor = FetchDescriptor<CachedMovie>()
        let cached = (try? context.fetch(descriptor)) ?? []
        return cached.map { $0.toDomain() }
    }
    
    public func saveMovies(_ movies: [Movie]) {
        movies.forEach { movie in
            context.insert(CachedMovie(movie: movie))
        }
        try? context.save()
    }
    
    public func clearMovies() {
        let descriptor = FetchDescriptor<CachedMovie>()
        let cached = (try? context.fetch(descriptor)) ?? []
        cached.forEach { context.delete($0) }
        try? context.save()
    }
    
    // MARK: - Movie details
    
    public func fetchMovieDetails(id: Int) -> MovieDetails? {
        let descriptor = FetchDescriptor<CachedMovieDetails>(
            predicate: #Predicate { $0.id == id }
        )
        return try? context.fetch(descriptor).first?.toDomain()
    }
    
    public func saveMovieDetails(_ details: MovieDetails) {
        context.insert(CachedMovieDetails(details: details))
        try? context.save()
    }
    
}
