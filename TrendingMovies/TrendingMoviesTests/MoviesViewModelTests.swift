//
//  MoviesViewModelTests.swift
//  TrendingMovies
//
//  Created by vodafone on 15/04/2026.
//


import XCTest
import Combine
import NetworkLayerSPM
import MoviesSPM
@testable import TrendingMovies
final class MoviesViewModelTests: XCTestCase {

    private var viewModel: MoviesViewModel!
    private var mockRepo: MockMovieRepository!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockRepo = MockMovieRepository()
    }

    override func tearDown() {
        viewModel = nil
        mockRepo = nil
        super.tearDown()
    }

    // MARK: - Fetch success

    @MainActor
    func testFetchMovies_success_updatesMoviesAndStopsLoading() {

        let expectation = XCTestExpectation(description: "Movies loaded")

        viewModel = MoviesViewModel(repo: mockRepo)

        viewModel.$movies
            .dropFirst()
            .sink { movies in
                if movies.count == 2 {
                    XCTAssertFalse(self.viewModel.isLoading)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // ✅ Explicit trigger (THIS IS THE KEY)
        viewModel.fetchMovies()

        wait(for: [expectation], timeout: 1)
    }
    // MARK: - Fetch failure
    @MainActor
    func testFetchMovies_failure_stopsLoadingAndReturnsEmpty() {

        mockRepo.shouldFail = true
        let expectation = XCTestExpectation(description: "Failure handled")

        viewModel = MoviesViewModel(repo: mockRepo)

        viewModel.$isLoading
            .dropFirst() // ignore initial true
            .sink { isLoading in
                if isLoading == false {
                    XCTAssertTrue(self.viewModel.movies.isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Search filter

    @MainActor
    func testSearchText_filtersMoviesCorrectly() {

        let expectation = XCTestExpectation(description: "Search filtering")

        viewModel = MoviesViewModel(repo: mockRepo)

        viewModel.$filteredMovies
            .dropFirst() // ignore initial empty
            .sink { movies in
                if movies.count == 1 {
                    XCTAssertEqual(movies.first?.title, "Batman")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.searchText = "bat"

        wait(for: [expectation], timeout: 1)
    }

    // MARK: - Genre filter

    @MainActor
    func testSelectedGenres_filtersMoviesCorrectly() {

        let expectation = XCTestExpectation(description: "Genre filtering")

        viewModel = MoviesViewModel(repo: mockRepo)

        viewModel.$filteredMovies
            .dropFirst()
            .sink { movies in
                if movies.count == 1 {
                    XCTAssertEqual(movies.first?.title, "Batman")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.selectedGenres = [1]

        wait(for: [expectation], timeout: 1)
    }
}
