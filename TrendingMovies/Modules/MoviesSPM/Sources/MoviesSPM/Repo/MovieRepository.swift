//
//  MovieRepository.swift
//  Movies-SPM
//
//  Created by vodafone on 13/04/2026.
//

import Foundation
import Combine
import NetworkLayerSPM

@MainActor
public protocol MovieRepositoryProtocol {
    func getMovies(page: Int) -> AnyPublisher<[Movie], NetworkError>
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetails, NetworkError>
}

// MARK: - Repository (Offline Support)
import Combine
import SwiftData

@MainActor
public final class MovieRepository: MovieRepositoryProtocol {
    
    private let api: ProductListServiceable
    private let cache: MoviesSwiftDataCache
    
    public init(
        api: ProductListServiceable,
        modelContext: ModelContext
    ) {
        self.api = api
        self.cache = MoviesSwiftDataCache(context: modelContext)
    }
    
    // MARK: - Movies list
    
    @MainActor
    public func getMovies(page: Int) -> AnyPublisher<[Movie], NetworkError> {
        
        if page == 1 {
            let cached = cache.fetchMovies()
            if !cached.isEmpty {
                return Just(cached)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
        }
        
        return api.fetchMovies(page: page)
            .map { [weak self] response in
                guard let self else { return response.results }
                
                if page == 1 {
                    self.cache.clearMovies()
                }
                
                self.cache.saveMovies(response.results)
                return self.cache.fetchMovies()
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Movie details
    
    @MainActor public func getMovieDetails(id: Int) -> AnyPublisher<MovieDetails, NetworkError> {
        
        if let cached = cache.fetchMovieDetails(id: id) {
            return Just(cached)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return api.fetchMovieDetails(id: id)
            .map { [weak self] movie in
                self?.cache.saveMovieDetails(movie)
                return movie
            }
            .eraseToAnyPublisher()
    }
}

