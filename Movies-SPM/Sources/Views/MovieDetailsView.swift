//
//  MovieDetailsView.swift
//  Movies-SPM
//
//  Created by vodafone on 12/04/2026.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieId: Int
    @StateObject private var vm = MovieDetailsViewModel(api: APIService())
    
    var body: some View {
        ScrollView {
            if let movie = vm.movie {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"))
                        { image in image.resizable() }
                        placeholder: { Color.gray }
                        .frame(height: 300)
                    
                    Text(movie.title)
                        .font(.title)
                    Text(movie.overview)
                    Text("Budget: \(movie.budget)")
                    Text("Revenue: \(movie.revenue)")
                    Text("Runtime: \(movie.runtime ?? 0)")
                }
                .padding()
            }
        }
        .onAppear {
            vm.fetch(id: movieId)
        }
    }
}

