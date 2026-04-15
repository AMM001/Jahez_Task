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
    
    private let api: ProductListServiceable
    private var cancellables = Set<AnyCancellable>()
    
    init(api: ProductListServiceable = ProductListService()) {
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
