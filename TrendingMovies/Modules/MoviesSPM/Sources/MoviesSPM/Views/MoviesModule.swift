//
//  MoviesModule.swift
//  Movies-SPM
//
//  Created by vodafone on 14/04/2026.
//

import Foundation
import NetworkLayerSPM
import SwiftUI

public struct MoviesModule {
    
    @MainActor public static func makeMoviesListView() -> some View {
        let service = ProductListService()
        let repo = MovieRepository(api: service)
        let vm = MoviesViewModel(repo: repo)
        
        return MoviesListView(vm: vm)
    }
}
