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
    func testFetchMovies_success_completesAndUpdatesState() {
        
        let expectation = XCTestExpectation(description: "Fetch movies completes")
        
        viewModel = MoviesViewModel(repo: mockRepo)
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading == false {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovies()
        
        wait(for: [expectation], timeout: 2)
    
        XCTAssertEqual(viewModel.movies.count, 20)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // MARK: - Fetch failure
    @MainActor
    func testFetchMovies_failure_stopsLoadingAndReturnsEmpty() {
        
        mockRepo.shouldFail = true
        let expectation = XCTestExpectation(description: "Failure handled")
        
        viewModel = MoviesViewModel(repo: mockRepo)
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading == false {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovies()
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertTrue(viewModel.movies.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    // MARK: - Search filter
    
    @MainActor
    func testSearchText_filtersMoviesCorrectly() {
        
        let expectation = XCTestExpectation(description: "Search filtering")
        
        viewModel = MoviesViewModel(repo: mockRepo)
        
        // Step 1: wait for fetch
        viewModel.$isLoading
            .dropFirst()
            .sink { [weak self] isLoading in
                guard let self else { return }
                
                if isLoading == false {
                    // Step 2: apply search
                    self.viewModel.searchText = "bat"
                    
                    DispatchQueue.main.async {
                        XCTAssertEqual(self.viewModel.filteredMovies.count, 0)
                        XCTAssertEqual(self.viewModel.filteredMovies.first?.title, nil)
                        expectation.fulfill()
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovies()
        
        wait(for: [expectation], timeout: 2)
    }
    // MARK: - Genre filter
    
    @MainActor
    func testSelectedGenres_filtersMoviesCorrectly() {
        
        let expectation = XCTestExpectation(description: "Genre filtering")
        
        viewModel = MoviesViewModel(repo: mockRepo)
        
        viewModel.$isLoading
            .dropFirst()
            .sink { [weak self] isLoading in
                guard let self else { return }
                
                if isLoading == false {
                    // Step 2: apply genre
                    self.viewModel.selectedGenres = [1]
                    
                    DispatchQueue.main.async {
                        XCTAssertEqual(self.viewModel.filteredMovies.count, 0)
                        XCTAssertEqual(self.viewModel.filteredMovies.first?.title, nil)
                        expectation.fulfill()
                    }
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchMovies()
        
        wait(for: [expectation], timeout: 2)
    }
}
