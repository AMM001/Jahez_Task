//
//  MoviesViewModel.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import Foundation
import NetworkLayer_SPM

public class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var searchText: String = ""
    @Published var selectedGenres: Set<Int> = []
    
    private let repo: MovieRepository
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    
    init(repo: MovieRepository) {
        self.repo = repo
        bind()
        fetchMovies()
    }
    
    private func bind() {
        Publishers.CombineLatest($searchText, $selectedGenres)
            .map { [weak self] search, genres in
                self?.movies.filter { movie in
                    let matchesSearch = search.isEmpty || movie.title.lowercased().contains(search.lowercased())
                    let matchesGenre = genres.isEmpty || !(Set(movie.genreIds ?? []).isDisjoint(with: genres))
                    return matchesSearch && matchesGenre
                } ?? []
            }
            .assign(to: &$filteredMovies)
    }
    
    func fetchMovies() {
        repo.getMovies(page: currentPage)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.currentPage += 1
            })
            .store(in: &cancellables)
    }
}
