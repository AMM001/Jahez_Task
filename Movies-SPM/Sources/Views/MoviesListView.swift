//
//  MoviesListView.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var vm: MoviesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $vm.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(vm.filteredMovies) { movie in
                    NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath ?? "")"))
                            { image in image.resizable() }
                            placeholder: { Color.gray }
                            .frame(width: 80, height: 120)
                            
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.releaseDate ?? "")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                
                Button("Load More") {
                    vm.fetchMovies()
                }
            }
            .navigationTitle("Trending Movies")
        }
    }
}
