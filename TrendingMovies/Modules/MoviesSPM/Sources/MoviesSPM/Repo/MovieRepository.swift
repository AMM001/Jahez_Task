//
//  MovieRepository.swift
//  Movies-SPM
//
//  Created by vodafone on 13/04/2026.
//

import Foundation
import Combine
import NetworkLayerSPM

// MARK: - Repository (Offline Support)
public class MovieRepository {
    private let api: ProductListServiceable
    private var cache: [Movie] = []
    
    public init(api: ProductListServiceable) {
        self.api = api
    }
    
    func getMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        return api.fetchMovies(page: page)
            .map { [weak self] response in
                self?.cache.append(contentsOf: response.results)
                return self?.cache ?? []
            }
            .catch { [weak self] _ in
                Just(self?.cache ?? []).setFailureType(to: Error.self)
            }
            .eraseToAnyPublisher()
    }
}
