//
//  MovieDetailsViewModel.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import Foundation
import NetworkLayerSPM
import Combine

public class MovieDetailsViewModel: ObservableObject {
    @Published var movie: MovieDetails?
    
    private let repo: MovieRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repo: MovieRepositoryProtocol) {
        self.repo = repo
    }
    
    @MainActor func fetch(id: Int) {
        repo.getMovieDetails(id: id)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movie in
                self?.movie = movie
            })
            .store(in: &cancellables)
    }
}
