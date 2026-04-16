//
//  MoviesModule.swift
//  Movies-SPM
//
//  Created by vodafone on 14/04/2026.
//

import Foundation
import NetworkLayerSPM
import SwiftUI
import SwiftData

public struct MoviesModule {

    public static func makeMoviesListView() -> some View {
        MoviesRootView()
    }
}

struct MoviesRootView: View {

    @Environment(\.modelContext)
    private var modelContext
    
    var body: some View {
        let service = ProductListService()
        let repo = MovieRepository(
            api: service,
            modelContext: modelContext
        )

        MoviesListView(
            vm: MoviesViewModel(repo: repo)
        )
    }
}

