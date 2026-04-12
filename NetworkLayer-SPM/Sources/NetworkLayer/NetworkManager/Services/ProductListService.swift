//
//  ProductListService.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Combine 
import Foundation

protocol ProductListServiceable {
    func fetchMovies(page: Int) -> AnyPublisher<MovieResponse, NetworkError>
    func fetchGenres() -> AnyPublisher<GenreResponse, NetworkError>
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetails, NetworkError>
}

class ProductListService: ProductListServiceable {

    private var networkRequest: Requestable
    private var environment: Environment
    
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func fetchMovies(page: Int) -> AnyPublisher<MovieResponse, NetworkError> {
        let endpoint = ServiceEndpoints.fetchMovies(page: page)
        let request = endpoint.createRequest(environment: environment)
        return networkRequest.request(request)
    }
    
    func fetchGenres() -> AnyPublisher<GenreResponse, NetworkError> {
        let endpoint = ServiceEndpoints.fetchGenres
        let request = endpoint.createRequest(environment: environment)
        return networkRequest.request(request)
    }
    
    func fetchMovieDetails(id: Int) -> AnyPublisher<MovieDetails, NetworkError> {
        let endpoint = ServiceEndpoints.fetchMovieDetails(id: id)
        let request = endpoint.createRequest(environment: environment)
        return networkRequest.request(request)
    }
}
