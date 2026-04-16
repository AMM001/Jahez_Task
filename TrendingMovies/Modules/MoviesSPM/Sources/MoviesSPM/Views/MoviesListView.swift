//
//  MoviesListView.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import SwiftUI
import NetworkLayerSPM

public struct MoviesListView: View {
    
    @StateObject var vm: MoviesViewModel
    @FocusState private var isSearching: Bool
    @Environment(\.modelContext) private var modelContext
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    public init(vm: MoviesViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // 🔍 Search Bar
                    HStack {
                        TextField("Search TMDB", text: $vm.searchText)
                            .focused($isSearching)
                            .padding(10)
                            .background(Color(.darkGray))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            vm.searchText = ""
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    // 🎬 Title
                    Text("Watch New Movies")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.yellow)
                        .padding(.horizontal)
                    
                    // 🎭 Genre Chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.genres, id: \.id) { genre in
                                Text(genre.name)
                                    .font(.subheadline)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(vm.selectedGenre == genre.id ? Color.yellow : Color.clear)
                                    .foregroundColor(vm.selectedGenre == genre.id ? .black : .white)
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.yellow, lineWidth: 1)
                                    )
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        vm.selectedGenre = genre.id
                                        vm.filterByGenre()
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // 🎞 Movies Grid + Loading
                    ZStack {
                        
                        if vm.isLoading && vm.filteredMovies.isEmpty {
                            // ⏳ First Load (center loader)
                            VStack {
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(.yellow)
                                Spacer()
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(vm.filteredMovies) { movie in
                                        let service = ProductListService()
                                        let repo = MovieRepository(
                                            api: service,
                                            modelContext: modelContext
                                        )
                                        NavigationLink(destination: MovieDetailsView(movieId: movie.id, vm: MovieDetailsViewModel(repo: repo))) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                // 🔄 Bottom Loader (pagination)
                                if vm.isLoading {
                                    ProgressView()
                                        .tint(.yellow)
                                        .padding()
                                }
                            }
                        }
                    }
                    
                    // 🔄 Load More Button
                    if !vm.filteredMovies.isEmpty {
                        Button(action: {
                            vm.fetchMovies()
                        }) {
                            Text(vm.isLoading ? "Loading..." : "Load More")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(vm.isLoading ? Color.gray : Color.yellow)
                                .cornerRadius(10)
                        }
                        .disabled(vm.isLoading)
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .task {
            vm.fetchMovies()
        }
        .onTapGesture {
            isSearching = false
        }
    }
}

struct MovieCard: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(height: 180)
            .cornerRadius(10)
            
            Text(movie.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(movie.releaseDate?.prefix(4) ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
