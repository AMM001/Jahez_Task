//
//  MoviesViewModel.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import Foundation
import NetworkLayerSPM
import Combine

import Combine
import SwiftUI

@MainActor
public class MoviesViewModel: ObservableObject {

    // MARK: - Published
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var searchText: String = ""
    @Published var selectedGenres: Set<Int> = []
    
    @Published var genres: [Genre] = []
    @Published var selectedGenre: Int?
    @Published var isLoading: Bool = false

    // MARK: - Private
    private let repo: MovieRepository
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1

    // MARK: - Init
    public init(repo: MovieRepository) {
        self.repo = repo
        bind()
        fetchMovies()
    }

    // MARK: - Bindings
    private func bind() {
        Publishers.CombineLatest3($searchText, $selectedGenres, $movies)
            .map { search, genres, movies -> [Movie] in
                
                movies.filter { movie in
                    let matchesSearch =
                        search.isEmpty ||
                        movie.title.localizedCaseInsensitiveContains(search)

                    let matchesGenre =
                        genres.isEmpty ||
                        !Set(movie.genreIds).isDisjoint(with: genres)

                    return matchesSearch && matchesGenre
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredMovies)
    }

    // MARK: - API
    func fetchMovies() {
        isLoading = true   // ✅ correct place
        repo.getMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoading = false   // ✅ stop loading even on error
                },
                receiveValue: { [weak self] movies in
                    guard let self else { return }
                    self.movies.append(contentsOf: movies)
                    self.currentPage += 1
                }
            )
            .store(in: &cancellables)
    }

    func filterByGenre() {
        guard let selectedGenre else {
            filteredMovies = movies
            return
        }
        
        filteredMovies = movies.filter {
            $0.genreIds.contains(selectedGenre)
        }
    }
}

