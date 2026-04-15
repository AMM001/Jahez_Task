//
//  MovieRepository.swift
//  Movies-SPM
//
//  Created by vodafone on 13/04/2026.
//

import Foundation
import Combine
import NetworkLayerSPM

public protocol MovieRepositoryProtocol {
    func getMovies(page: Int) -> AnyPublisher<[Movie], NetworkError>
}

// MARK: - Repository (Offline Support)
public class MovieRepository: MovieRepositoryProtocol {

    private let api: ProductListServiceable
    private var cache: [Movie] = []

    public init(api: ProductListServiceable) {
        self.api = api
    }

    public func getMovies(page: Int) -> AnyPublisher<[Movie], NetworkError> {

        api.fetchMovies(page: page)
            .map { [weak self] response in
                guard let self else { return [] }
                self.cache.append(contentsOf: response.results)
                return self.cache
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    public func resetCache() {
        cache.removeAll()
    }
}
