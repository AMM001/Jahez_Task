//
//  MovieDetailsViewModel.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var movie: MovieDetails?
    
    private let api: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(api: APIServiceProtocol) {
        self.api = api
    }
    
    func fetch(id: Int) {
        api.fetchMovieDetails(id: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movie in
                self?.movie = movie
            })
            .store(in: &cancellables)
    }
}
