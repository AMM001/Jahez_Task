//
//  MockMovieRepository 2.swift
//  TrendingMovies
//
//  Created by vodafone on 15/04/2026.
//


import Combine
import NetworkLayerSPM
import MoviesSPM
import Foundation
@testable import TrendingMovies


import Combine

final class MockMovieRepository: MovieRepositoryProtocol {

    var shouldFail: Bool = false
    var jsonFileName: String = "moviesModel"

    func getMovies(page: Int) -> AnyPublisher<[Movie], NetworkError> {

        if shouldFail {
            return Fail(
                error: NetworkError.serverError(
                    code: -1,
                    error: "Mock failure"
                )
            )
            .eraseToAnyPublisher()
        }

        let response: MovieResponse =
            JSONLoader.load(
                filename: jsonFileName,
                bundle: Bundle(for: MockMovieRepository.self)
            )

        return Just(response.results)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

